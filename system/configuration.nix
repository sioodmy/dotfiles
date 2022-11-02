{ config, pkgs, lib, inputs, ... }:

with lib;

let
  # this is required for wayland stuff
  dbus-hyprland-environment = pkgs.writeTextFile {
    name = "dbus-hyprland-environment";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
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
  # disabledModules = [ "services/hardware/udev.nix" ];
  imports = [
    ./nvidia.nix
    ./bootloader.nix
    ./fonts.nix
    ./network.nix
    ./schizo.nix
    ./services.nix
  ];
  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
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
      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
        "https://fortuneteller2k.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  documentation.enable = false; # its trash anyways

  services.journald.extraConfig = ''
    SystemMaxUse=50M
    RuntimeMaxUse=10M
  '';

  services.dbus.enable = true;

  services.dbus.packages = with pkgs; [ dconf ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    dbus-hyprland-environment
    configure-gtk
    cryptsetup
  ];

  environment.defaultPackages = [ ]; # this removes bloat (not really)
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  programs = {
    ccache.enable = true;
    hyprland = {
      enable = true;
      # credits to IceDBorn and fufexan for this patch <3
      package = inputs.hyprland.packages.${pkgs.system}.default.override {
        nvidiaPatches = true;
        wlroots =
          inputs.hyprland.packages.${pkgs.system}.wlroots-hyprland.overrideAttrs
          (old: {
            patches = (old.patches or [ ]) ++ [
              (pkgs.fetchpatch {
                url =
                  "https://aur.archlinux.org/cgit/aur.git/plain/0001-nvidia-format-workaround.patch?h=hyprland-nvidia-screenshare-git";
                sha256 = "A9f1p5EW++mGCaNq8w7ZJfeWmvTfUm4iO+1KDcnqYX8=";
              })
            ];
          });

      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = [ "multi-user.target" ];
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

  system.autoUpgrade.enable = false;

  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
