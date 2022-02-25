{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
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
  };
  outputs = { nixpkgs, home-manager, nur, picom-ibhagwan, ...}: 
  let 
    system = "x86_64-linux";

    lib = nixpkgs.lib; 

  in {
    nixosConfigurations = {
      graphene = lib.nixosSystem {
        inherit system;

        modules = [
          ./packages.nix ./system/configuration.nix ./system/hardware-configuration.nix ./system/hosts/graphene.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.sioodmy = {

                imports = [
                  ./config/bspwm
                  ./config/sxhkd
                  ./config/dunst
                  ./config/urxvt
                  ./config/picom
                  ./config/nvim
                  ./config/zsh
                  ./config/xresources
                  ./config/xdg
                  ./config/bat
                  ./config/git
                  ./config/zathura
                  ./config/rofi
                  ./config/polybar
                  ./config/chromium
                  ./config/gtk
                  ./config/betterlockscreen
                  ./config/music
                  ./config/udiskie
                  ./config/flameshot
                ];
              };
            };

            nixpkgs.overlays = [
              (final: prev: {
                picom = prev.picom.overrideAttrs (o: {
                  src = picom-ibhagwan;
                });
              })
              (final : prev: {
                bspswallow = prev.callPackage ./overlays/bspswallow.nix { };
                catppuccin-gtk = prev.callPackage ./overlays/catppuccin-gtk.nix { };
              })

              nur.overlay
            ];
          }
        ];
      };
    };
  };
}
