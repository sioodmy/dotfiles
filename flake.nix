{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    picom-ibhagwan = {
      url = "github:ibhagwan/picom";
      flake = false;
    };

    discord-overlay = {
      url = "github:InternetUnexplorer/discord-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    discocss = {
      url = "github:mlvzk/discocss/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eww.url = "github:elkowar/eww";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    todo.url = "github:sioodmy/todo";
    fetch.url = "github:sioodmy/fetch";

  };
  outputs = inputs@{ self, nixpkgs, home-manager, nur, picom-ibhagwan
    , eww, discord-overlay, discocss, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            (./. + "/hosts/${hostname}/system.nix")
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            ./modules/system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                sharedModules = [ discocss.hmModule ];
                extraSpecialArgs = {
                  inherit inputs;
                };
                users.sioodmy = (./. + "/hosts/${hostname}/user.nix");
              };
              nixpkgs.overlays = [
                (final: prev: {
                  picom =
                    prev.picom.overrideAttrs (o: { src = picom-ibhagwan; });
                })
                (final: prev: {
                  discocss = prev.discocss.overrideAttrs (oldAttrs: rec {
                    patches = (oldAttrs.patches or [ ])
                      ++ [ ./overlays/discocss-no-launch.patch ];
                  });
                  catppuccin-gtk =
                    prev.callPackage ./overlays/catppuccin-gtk.nix { };
                  catppuccin-cursors =
                    prev.callPackage ./overlays/catppuccin-cursors.nix { };
                  catppuccin-grub =
                    prev.callPackage ./overlays/catppuccin-grub.nix { };
                })
                nur.overlay
                discord-overlay.overlay
                neovim-nightly-overlay.overlay
              ];
            }

          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        graphene = mkSystem inputs.nixpkgs "x86_64-linux" "graphene";
        thinkpad = mkSystem inputs.nixpkgs "x86_64-linux" "thinkpad";
      };

      devShell.x86_64-linux = pkgs.mkShell { packages = [ pkgs.nixfmt ]; };
    };
}
