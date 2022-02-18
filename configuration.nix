{ config, pkgs, ... }:

{
    environment.variables = {
        NIXOS_CONFIG="$HOME/.config/nixos/configuration.nix";
        NIXOS_CONFIG_DIR="$HOME/.config/nixos/";
        EDITOR="nvim";
    };
    imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
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

    
    environment.defaultPackages = [ ];
    nixpkgs.config.allowUnfree = true;
  
    boot = {
        cleanTmpDir = true;
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
        keyMap = "us";
    };

    services.cron = {
        enable = true;
    };
   
    services.xserver = {
        layout = "pl";
        enable = true;
	    videoDrivers = [ "nvidia" ];
#            displayManager.lightdm.enable = true;
            displayManager.lightdm.greeters.mini = {
                enable = true;
                user = "sioodmy";
                extraConfig = ''
                    [greeter]
                    show-password-label = false
                    invalid-password-text = Access Denied
                    show-input-cursor = true
                    password-alignment = left
                    [greeter-theme]
                    font-size = 1em
                    background-image = ""
                    background-color = "#1E1E2E"
                    window-color = "#1E1E2E"
                    password-border-radius = 10px
                    password-border-width = 3px
                    password-border-color = "#ABE9B3"
                    password-background-color = "#1E1E2E"
                    border-width = 0px
                '';
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
    };

    users.users.sioodmy = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.zsh;
    };

    fonts.fonts = with pkgs; [
        jetbrains-mono 
        roboto
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = false;

    networking = {
        hostName = "nixos";
        networkmanager.enable = true;
        interfaces = {
            enp24s0.useDHCP = true;
        };
        firewall = {
            enable = true;
            allowedTCPPorts = [ 443 80 ];
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

    # enable and secure ssh
    services.openssh = { 
        enable = true;
        permitRootLogin = "no";
        passwordAuthentication = false;
    };

    security.protectKernelImage = true;
    system.stateVersion = "21.11"; # DONT TOUCH THIS 

}

