{ config, pkgs, lib, inputs, ... }:

with lib;

let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gesettings/schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gesettings set $gnome_schema gtk-theme 'Adwaita'
    '';
  };

in {
  disabledModules = [ "services/hardware/udev.nix" ];
  imports = [ ./udev.nix ];
  environment = {
    variables = {
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
      TERMINAL = "st";
      BROWSER = "brave";
      GBM_BACKEND = "nvidia-drm";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      DISABLE_QT5_COMPAT = "0";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      CLUTTER_BACKEND = "wayland";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };
    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(ssh-agent)
      eval $(gnome-keyring-daemon --start)
      export GPG_TTY=$TTY
    '';
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 4d";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "sioodmy" ];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://fortuneteller2k.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      (pkgs.xdg-desktop-portal-gtk.override { buildPortalsInGnome = false; })
    ];
    wlr = {
      enable = true;
      settings.screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
  };

  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    configure-gtk
    cryptsetup
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      open = true;
      modesetting.enable = true;
    };
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  environment.defaultPackages = [ ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    cleanTmpDir = true;
    kernelParams = [
      "pti=on"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "slab_nomerge"
      "debugfs=off"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "page_poison=1"
      "page_alloc.shuffle=1"
      "slub_debug=FZP"
      "sysrq_always_enabled=1"
      "rootflags=noatime"
      "iommu=pt"
      "usbcore.autosuspend=-1"
      "sysrq_always_enabled=1"
      "lsm=landlock,lockdown,yama,apparmor,bpf"
      "loglevel=7"
      "rd.udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
        theme = null;
        backgroundColor = null;
        splashImage = null;
      };
    };
  };

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networkmanager = {
      enable = true;
      unmanaged = [ "docker0" "rndis0" ];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 25565 ];
      allowedUDPPorts = [ 443 80 44857 ];
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  programs.xwayland.enable = true;
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland-nvidia;
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "sioodmy";
      group = "wheel";
      dataDir = "/home/sioodmy/syncthing";
      configDir = "/home/sioodmy/.config/syncthing/";
      systemService = true;

    };
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "sioodmy";
        };
        default_session = initial_session;
      };
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };

    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;

    tor = {
      enable = true;
      torsocks.enable = true;
    };

    # enable and secure ssh
    openssh = {
      enable = false;
      permitRootLogin = "no";
      passwordAuthentication = true;
    };

    # Use pipewire instead of soyaudio
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  users.users.sioodmy = {
    isNormalUser = true;
    # Enable ‘sudo’ for the user.
    extraGroups = [
      "wheel"
      "systemd-journal"
      "audio"
      "video"
      "input"
      "lp"
      "networkmanager"
    ];
    uid = 1000;
    shell = pkgs.zsh;

  };

  fonts = {
    fonts = with pkgs; [
      material-icons
      material-design-icons
      roboto
      work-sans
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
    ];

    enableDefaultFonts = false;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  system.autoUpgrade.enable = false;

  # Security
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"
    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "vivid"
    "gfs2"
    "ksmbd"
    "nfsv4"
    "nfsv3"
    "cifs"
    "nfs"
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "squashfs"
    "udf"
    "bluetooth"
    "btusb"
    "uvcvideo" # webcam
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "uvcvideo"
    "qnx4"
    "qnx6"
    "sysv"
  ];

  security = {
    protectKernelImage = true;
    lockKernelModules = true;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
    pam.services = {
      login.enableGnomeKeyring = true;
      swaylock = {
        text = ''
          auth include login
        '';
      };
    };
    sudo.execWheelOnly = true;
  };

  boot.kernel.sysctl = {
    "kernel.yama.ptrace_scope" = 2;
    "kernel.kptr_restrict" = mkOverride 500 2;
    "net.core.bpf_jit_enable" = false;
    "kernel.ftrace_enabled" = false;
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.log_martians" = true;
    "net.ipv4.conf.default.rp_filter" = "1";
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv6.conf.default.accept_ra" = 0;
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
  };

  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
