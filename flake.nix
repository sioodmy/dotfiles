{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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

  };
  outputs = inputs@{ self, nixpkgs, home-manager, nur, unstable, picom-ibhagwan
    , eww, discord-overlay, discocss, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";

      lib = nixpkgs.lib;

      overlays = [
        (final: prev: {
          picom =
            prev.picom.overrideAttrs (o: { src = picom-ibhagwan; });
          })
          (final: prev: {
            bspswallow = prev.callPackage ./overlays/bspswallow.nix { };
            catppuccin-gtk =
              prev.callPackage ./overlays/catppuccin-gtk.nix { };
              catppuccin-cursors =
                prev.callPackage ./overlays/catppuccin-cursors.nix { };
                catppuccin-grub =
                  prev.callPackage ./overlays/catppuccin-grub.nix { };
                  fetch = prev.callPackage ./overlays/fetch.nix { };
                })
                nur.overlay
                discord-overlay.overlay
                neovim-nightly-overlay.overlay
              ];

    in {
      nixosConfigurations = {
        graphene = lib.nixosSystem {
          inherit system;

          modules = [
            ./system/configuration.nix
            ./system/hardware-configuration.nix
            ./system/hosts/graphene.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ discocss.hmModule ];
                extraSpecialArgs = {
                  inherit inputs;
                  theme = import ./theme;
                };
                users.sioodmy = import ./home;
              };

              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };
  }
