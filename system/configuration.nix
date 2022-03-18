{ config, pkgs, lib, theme,  ... }:

with lib;

let 
  theme = import ../theme;
in
  {
    environment.variables = {
      NIXOS_CONFIG="$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR="$HOME/.config/nixos/";
      EDITOR="nvim";
      TERMINAL="alacritty";
      BROWSER="firefox";
    };

    nix = {
      autoOptimiseStore = true;
      allowedUsers = [ "sioodmy" ];
      gc = {
        automatic = true;
        dates = "daily";
      };
      package = pkgs.nixUnstable;
      extraOptions = ''
            experimental-features = nix-command flakes
      '';
    };

    hardware = {
      opengl.driSupport32Bit = true;
      pulseaudio.support32Bit = true;
      nvidia.modesetting.enable = true;
    };

    environment.defaultPackages = [ ];
    nixpkgs.config.allowUnfree = true;

    boot = {
      cleanTmpDir = true;
      plymouth.enable = true;
      kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];
      kernelPackages = pkgs.linuxPackages_latest;
      # kernelPackages = pkgs.linuxPackages_xanmod;
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
            repo = "grubb";
            rev = "3f62cd4174465631b40269a7c5631e5ee86dec45";
            sha256 = "d15FS7R78kdUKqC7EAei5Pe0Vuj2boVnm4WZYQdPURo=";
          } + "/catppuccin-grub-theme";
        };
      };
    };

    time.timeZone = "Europe/Warsaw";

    i18n.defaultLocale = "en_US.UTF-8";

    console = {
      font = "Lat2-Terminus16";
      keyMap = "pl";
    };

    environment.etc."libinput-gestures.conf".text = ''
      gesture swipe right 3 bspc desktop -f next.local
      gesture swipe left 3 bspc desktop -f prev.local
    '';

    sound.enable = true;

    services = {
      logind = {
        lidSwitch = "lock";
        extraConfig = ''
          HandlePowerKey=suspend-then-hibernate
        '';
      };

      tlp = {
        enable = true;
        settings = {
          DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
          DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
          DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
          DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
          DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "";
          DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "";
        };
      };

      cron = {
        enable = true;
        systemCronJobs = [
          "@weekly      root    tldr --update"
        ];
      };

      printing.enable = true;

      xserver = {
        layout = "pl";
        videoDrivers = [ "nvidia" ];
        enable = true;
        enableTCP = false;
        exportConfiguration = false;
        desktopManager = {
          xterm.enable = false;
          xfce.enable = false;
        };
        displayManager.lightdm.greeters.mini = with theme.colors; {
          enable = true;
          user = "sioodmy";
          extraConfig = "
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
          font = \"${font}\";
          background-image = \"\"
          background-color = \"#${bg}\"
          window-color = \"#${bg}\"
          password-border-radius = 10px
          password-border-width = 3px
          password-border-color = \"#${ac}\"
          password-background-color = \"#${bg}\"
          border-width = 0px
          text-color = \"#${ac}\"
          ";
        };
        windowManager.bspwm.enable = true;

        libinput = {
          enable = true;
          touchpad.naturalScrolling = false;
        };
      };

      # enable and secure ssh
      openssh = { 
        enable = true;
        permitRootLogin = "no";
        passwordAuthentication = false;
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
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
    };

    fonts.fonts = with pkgs; [
      jetbrains-mono 
      roboto
      source-sans
      twitter-color-emoji
      inter
      iosevka
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
    ];

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
