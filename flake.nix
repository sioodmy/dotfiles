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

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    discord-overlay = {
      url = "github:InternetUnexplorer/discord-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    discocss.url = "github:mlvzk/discocss/flake";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    eww.url = "github:elkowar/eww";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    todo.url = "github:sioodmy/todo";
    st.url = "github:siduck/st";
    fetch.url = "github:sioodmy/fetch";

  };
  outputs = inputs@{ self, nixpkgs, home-manager, nur, eww, ... }:
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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.sioodmy = (./. + "/hosts/${hostname}/user.nix");
                sharedModules = with inputs; [ discocss.hmModule ];
              };
              nixpkgs.overlays = [
                (final: prev: {
                  catppuccin-cursors =
                    prev.callPackage ./overlays/catppuccin-cursors.nix { };
                })
                nur.overlay
                inputs.discord-overlay.overlay

                inputs.nixpkgs-f2k.overlays.default
                inputs.neovim-nightly-overlay.overlay
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

      checks.${system}.pre-commit-check =
        inputs.pre-commit-hooks.lib.${system}.run {
          src = self;
          hooks.nixpkgs-fmt.enable = true;
          hooks.shellcheck.enable = true;
        };
    };
}
