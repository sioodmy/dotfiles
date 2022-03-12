{ config, pkgs, lib, theme, ... }:

with lib;

let 
  theme = import ../theme;
in
{
    environment.variables = {
        NIXOS_CONFIG="$HOME/.config/nixos/configuration.nix";
        NIXOS_CONFIG_DIR="$HOME/.config/nixos/";
        EDITOR="nvim";
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
    };

    environment.defaultPackages = [ ];
    nixpkgs.config.allowUnfree = true;
  
    boot = {
        cleanTmpDir = true;
        plymouth.enable = true;
        kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];
        kernelPackages = pkgs.linuxPackages_latest;
        consoleLogLevel = 0;
        initrd.verbose = false;
        loader = {
          systemd-boot.enable = true;
          systemd-boot.editor = false;
          efi.canTouchEfiVariables = true;
        };
      };

      time.timeZone = "Europe/Warsaw";

      i18n.defaultLocale = "en_US.UTF-8";

      console = {
        font = "Lat2-Terminus16";
        keyMap = "pl";
      };

      services.cron.enable = true;
      
      services.printing.enable = true;

      services.xserver = {
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


      sound.enable = true;

    # Use pipewire instead of soyaudio
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    environment.systemPackages = with pkgs; [ pulseaudio ]; # for some reason this is required     


    users.users.sioodmy = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
    };

    fonts.fonts = with pkgs; [
      jetbrains-mono 
      roboto
      source-sans
      twemoji-color-font
      inter
      iosevka
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
    ];

    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = false;


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

    # enable and secure ssh
    services.openssh = { 
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };

    security.protectKernelImage = true;
    system.stateVersion = "21.11"; # DONT TOUCH THIS 

  }

