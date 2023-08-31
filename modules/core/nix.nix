{
  config,
  pkgs,
  lib,
  inputs,
  inputs',
  ...
}: {
  imports = [inputs.nh.nixosModules.default];
  environment = {
    # set channels (backwards compatibility)
    sessionVariables.FLAKE = "/home/sioodmy/dev/dotfiles";
    etc = {
      "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
      "nix/flake-channels/home-manager".source = inputs.home-manager;
    };

    systemPackages = with pkgs; [git deadnix alejandra statix inputs.nh.packages.${pkgs.system}.default nix-output-monitor];
    defaultPackages = [];
  };

  nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  nixpkgs = {
    config = {
      allowUnfree = false;
      allowBroken = true;
      permittedInsecurePackages = [
        "openssl-1.1.1u"
      ];
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "steam-run"
          "steam"
          "steam-original"
          "vscode"
          "spotify"
          "nvidia-x11"
          "nvidia-settings"
          # they got fossed recently so idk
          "Anytype"
        ];
      overlays = [
        (
          _: prev: {
            nixSuper = inputs'.nix-super.packages.default;
            # temp fix until https://github.com/NixOS/nixpkgs/pull/249382 is merged
            gtklock = prev.gtklock.overrideAttrs (self: super: {
              nativeBuildInputs = super.nativeBuildInputs ++ [prev.wrapGAppsHook];
              buildInputs = super.buildInputs ++ [prev.librsvg];
            });
          }
        )
      ];
    };
  };

  # faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    package = pkgs.nixUnstable;

    # Make builds run with low priority so my system stays responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes recursive-nix
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      # allow sudo users to mark the following values as trusted
      allowed-users = ["@wheel"];
      # only allow sudo users to manage the nix store
      trusted-users = ["@wheel"];
      sandbox = true;
      max-jobs = "auto";
      # continue building derivations if one fails
      keep-going = true;
      log-lines = 20;
      extra-experimental-features = ["flakes" "nix-command" "recursive-nix" "ca-derivations"];

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];
    };
  };
  system.autoUpgrade.enable = false;
  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
