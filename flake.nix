{
  description = "My NixOS configuration";

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

    kernel = {
      url = "https://git.kernel.org/torvalds/t/linux-6.0-rc6.tar.gz";
      flake = false;
    };

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    hyprland.url = "github:hyprwm/Hyprland/";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    webcord.url = "github:fufexan/webcord-flake";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

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
                  catppuccin-cursors =
                    prev.callPackage ./overlays/catppuccin-cursors.nix { };
                  hyprland-nvidia =
                    inputs.hyprland.packages.${prev.system}.default.override {
                      nvidiaPatches = true;
                    };
                })
                (self: super: {
                  vimPlugins = super.vimPlugins // (with super.vimPlugins; {
                    orgmode =
                      orgmode.overrideAttrs (old: { src = inputs.orgmode; });
                    nvim-treesitter = nvim-treesitter.overrideAttrs
                      (old: { src = inputs.nvim-treesitter; });
                  });
                  tree-sitter-org = let
                    actualRev = inputs.tree-sitter-org.rev;
                    ntsExpected = (super.lib.importJSON
                      "${inputs.nvim-treesitter}/lockfile.json").org.revision;
                    orgmodeExpected = builtins.readFile
                      (super.runCommand "orgmodeExpectedRev" { } ''
                        sed -n -e "2s/^local ts_revision = '\([^']\+\)'$/\1/p" \
                            ${inputs.orgmode}/lua/orgmode/init.lua \
                            | tr -d '\n' > $out
                      '');
                  in assert actualRev == ntsExpected;
                  assert actualRev == orgmodeExpected;
                  super.tree-sitter-grammars.tree-sitter-org-nvim.overrideAttrs
                  (old: { src = inputs.tree-sitter-org; });
                  waybar = super.waybar.overrideAttrs (oldAttrs: {
                    src = inputs.waybar;
                    mesonFlags = oldAttrs.mesonFlags
                      ++ [ "-Dexperimental=true" ];
                    patchPhase = ''
                      substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
                    '';
                  });
                })
                inputs.nixpkgs-wayland.overlay
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
    };
}
