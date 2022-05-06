{ config, pkgs, lib, theme, ... }:

with lib;

let
  theme = import ../theme;
in {
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  nix = {
    autoOptimiseStore = true;
    allowedUsers = [ "sioodmy" ];
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 4d";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  environment.defaultPackages = [ ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    cleanTmpDir = true;
    plymouth.enable = true;
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "nmi_watchdog=0"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        theme = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "grub";
          rev = "3f62cd4174465631b40269a7c5631e5ee86dec45";
          sha256 = "d15FS7R78kdUKqC7EAei5Pe0Vuj2boVnm4WZYQdPURo=";
        } + "/catppuccin-grub-theme";
      };
    };
  };

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 25565 ];
      allowedUDPPorts = [ 443 80 44857 ];
      allowPing = false;
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --sport 44857 -j RETURN
        ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --dport 44857 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --sport 44857 -j RETURN || true
        ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --dport 44857 -j RETURN || true
      '';
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  environment.etc."libinput-gestures.conf".text = ''
    gesture swipe right 3 bspc desktop -f next.local
    gesture swipe left 3 bspc desktop -f prev.local
  '';

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  services = {
    logind = {
      lidSwitch = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
      '';
    };

    cron = {
      enable = true;
      systemCronJobs = [ "@weekly      root    tldr --update" ];
    };

    printing.enable = true;
    fstrim.enable = true;

    xserver = {
      layout = "pl";
      xkbOptions = "caps:swapescape";
      enable = true;
      enableTCP = false;
      exportConfiguration = false;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = false;
      };
      displayManager = {
        autoLogin = {
          enable = true;
          user = "sioodmy";
        };
        lightdm.greeters.mini = with theme.colors; {
          enable = true;
          user = "sioodmy";
          extraConfig =
            ''
            [greeter]
            show-password-label = false
            invalid-password-text = Access Denied
            show-input-cursor = true
            password-alignment = left
            [greeter-hotkeys]
            mod-key = meta
            shutdown-key = s
            [greeter-theme]
            font-size = 1em
            font = "monospace";
            background-image = ""
            background-color = "#${bg}"
            window-color = "#${bg}"
            password-border-radius = 10px
            password-border-width = 3px
            password-border-color = "#${ac}"
            password-background-color = "#${bg}"
            border-width = 0px
            text-color = "#${ac}"
            '';
        };
      };
      windowManager.bspwm.enable = true;

      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "0";
          middleEmulation = false;
        };

        touchpad = {
          disableWhileTyping = true;
          accelProfile = "flat";
          accelSpeed = "0.6";
          naturalScrolling = true;
        };
      };
    };

    # enable and secure ssh
    openssh = {
      enable = true;
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
      pulse.enable = true;
      jack.enable = true;
    };
  };

  users.users.sioodmy = {
    isNormalUser = true;
    # Enable ‘sudo’ for the user.
    extraGroups = [ "wheel" ] ++ optionals config.services.xserver.enable [
      "audio"
      "video"
      "input"
      "lp"
      "networkmanager"
    ];
    uid = 1000;
    shell = pkgs.zsh;

  };

  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };

  fonts = {
    fonts = with pkgs; [
      material-design-icons
      roboto
      source-sans
      twemoji-color-font
      comfortaa
      inter
      iosevka
      lato
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (pkgs.iosevka.override {
        privateBuildPlan = ''
          [buildPlans.iosevka-custom]
          family = "Iosevka Custom"
          spacing = "normal"
          serifs = "sans"
          no-cv-ss = true
          no-ligation = true

          [buildPlans.iosevka-custom.variants]
          inherits = "ss14"
        '';
        set = "custom";
      })
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];

    enableDefaultFonts = false;

    fontconfig = with theme.colors; {
      defaultFonts = {
        monospace = [ "Iosevka Custom" "Noto Color Emoji" "Iosevka Nerd Font" ];
        sansSerif = [ "Lato" "Noto Color Emoji" ];
        serif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    allowReboot = false;
  };

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
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];

  environment.etc."sudo_lecture" = {
    text = ''
      [1m     [32m"Bee" careful    [34m__
             [32mwith sudo!    [34m// \
                           \\_/ [33m//
         [35m'''-.._.-'''-.._.. [33m-(||)(')
                           ''''[0m
    '';
    mode = "444";
  };

  security = {
    rtkit.enable = true;
    apparmor = {
      enable = true;
      packages = [ pkgs.apparmor-profiles ];
    };
    pam.services.login.enableGnomeKeyring = true;
    sudo.extraConfig = ''
      Defaults    lecture = always
      Defaults    lecture_file = /run/current-system/etc/sudo_lecture
    '';
  };

  boot.kernel.sysctl = {
    "kernel.yama.ptrace_scope" = mkOverride 500 1;
    "kernel.kptr_restrict" = mkOverride 500 2;
    "net.core.bpf_jit_enable" = mkDefault false;
    "kernel.ftrace_enabled" = mkDefault false;
    "net.ipv4.conf.all.log_martians" = mkDefault true;
    "net.ipv4.conf.all.rp_filter" = mkDefault "1";
    "net.ipv4.conf.default.log_martians" = mkDefault true;
    "net.ipv4.conf.default.rp_filter" = mkDefault "1";
    "net.ipv4.icmp_echo_ignore_broadcasts" = mkDefault true;
    "net.ipv4.conf.all.accept_redirects" = mkDefault false;
    "net.ipv4.conf.all.secure_redirects" = mkDefault false;
    "net.ipv4.conf.default.accept_redirects" = mkDefault false;
    "net.ipv4.conf.default.secure_redirects" = mkDefault false;
    "net.ipv6.conf.all.accept_redirects" = mkDefault false;
    "net.ipv6.conf.default.accept_redirects" = mkDefault false;
    "net.ipv4.conf.all.send_redirects" = mkDefault false;
    "net.ipv4.conf.default.send_redirects" = mkDefault false;
  };

  security.protectKernelImage = true;
  system.stateVersion = "21.11"; # DONT TOUCH THIS
}
