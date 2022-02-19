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
            desktop = lib.nixosSystem {
                inherit system;

                modules = [
                    ./configuration.nix ./packages.nix ./hosts/desktop.nix
                    home-manager.nixosModules.home-manager {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.sioodmy = {
                            
                                imports = [
                                   ./config/bspwm.nix
                                   ./config/sxhkd.nix
                                   ./config/dunst.nix
                                   ./config/urxvt.nix
                                   ./config/picom.nix
                                   ./config/nvim.nix
                                   ./config/zsh.nix
                                   ./config/xresources.nix
                                   ./config/xdg.nix
                                   ./config/bat.nix
                                   ./config/git.nix
                                   ./config/zathura.nix
                                   ./config/rofi.nix
                                   ./config/polybar.nix
                                   ./config/cursor.nix
                                   ./config/chromium.nix
                                   ./config/gtk.nix
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
