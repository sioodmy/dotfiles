{
  description = "My NixOS configuration";
  # https://github.com/sioodmy/dotfiles

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    hyprland.url = "github:hyprwm/Hyprland/";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    waybar = {
      url = "github:Alexays/Waybar";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
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
            inputs.hyprland.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.sioodmy = (./. + "/hosts/${hostname}/user.nix");
              };
              nixpkgs.overlays = [
                (final: prev: {
                  catppuccin-folders =
                    final.callPackage ./overlays/catppuccin-folders.nix { };
                  catppuccin-cursors =
                    prev.callPackage ./overlays/catppuccin-cursors.nix { };
                  catppuccin-gtk =
                    prev.callPackage ./overlays/catppuccin-gtk.nix { };
                  waybar = prev.waybar.overrideAttrs (oldAttrs: {
                    src = inputs.waybar;
                    mesonFlags = oldAttrs.mesonFlags
                      ++ [ "-Dexperimental=true" ];
                    patchPhase = ''
                      substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
                    '';
                  });
                  hyprland-nvidia =
                    inputs.hyprland.packages.${system}.default.override {
                      nvidiaPatches = true;
                      wlroots =
                        inputs.hyprland.packages.${system}.wlroots-hyprland.overrideAttrs
                        (old: {
                          patches = (old.patches or [ ])
                            ++ [ ./overlays/screenshare-patch.diff ];
                        });

                    };
                })
                inputs.nixpkgs-wayland.overlay
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

      devShells.${system}.default =
        pkgs.mkShell { packages = [ pkgs.alejandra ]; };
    };
}
