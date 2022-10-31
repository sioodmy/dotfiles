{
  description = "My NixOS configuration";
  # https://github.com/sioodmy/dotfiles

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    waybar = {
      url = "github:Alexays/Waybar";
      flake = false;
    };

    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };

    neorg-telescope-nvim = {
      url = "github:nvim-neorg/neorg-telescope";
      flake = false;
    };

    catppuccin-nvim = {
      url = "github:catppuccin/nvim";
      flake = false;
    };

    tree-sitter-org = {
      url = "github:milisims/tree-sitter-org";
      flake = false;
    };

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    hyprland.url = "github:hyprwm/Hyprland/";
    webcord.url = "github:fufexan/webcord-flake";

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
            ./modules/system/adblock.nix
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
                (self: super: {
                  vimPlugins = super.vimPlugins // (with super.vimPlugins; {
                    orgmode =
                      orgmode.overrideAttrs (old: { src = inputs.orgmode; });
                    nvim-treesitter = nvim-treesitter.overrideAttrs
                      (old: { src = inputs.nvim-treesitter; });
                  });
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

      devShell.${system} = pkgs.mkShell {
        packages = [ pkgs.nixpkgs-fmt ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    };
}
