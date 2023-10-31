{
  description = "My NixOS configuration";
  # https://dotfiles.sioodmy.dev

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    impermanence.url = "github:nix-community/impermanence";

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # project shells
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # feature-rich and convenient fork of the Nix package manager
    nix-super.url = "github:privatevoid-net/nix-super";

    schizofox = {
      url = "github:schizofox/schizofox/gerg";
      # url = "path:/home/sioodmy/dev/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        nixpak.follows = "nixpak";
      };
    };

    # a tree-wide formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprcontrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    helix = {
      # Fork of SoraTenshi's helix fork with typst support
      url = "github:sioodmy/helix/add-typst";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    shadower = {
      url = "github:n3oney/shadower";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-wsl = {
      url = "github:viperML/home-manager-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    cryptorun = {
      url = "github:sioodmy/anyrun-crypto";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        # systems for which you want to build the `perSystem` attributes
        "x86_64-linux"
        "aarch64-linux"
        # and more if they can be supported ...
      ];

      imports = [
        # add self back to inputs, I depend on inputs.self at least once
        {config._module.args._inputs = inputs // {inherit (inputs) self;};}

        # parts and modules from inputs
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        inputs',
        config,
        pkgs,
        ...
      }: {
        # provide the formatter for nix fmt
        formatter = pkgs.alejandra;

        devShells.default = let
          extra = import ./devShell;
        in
          inputs'.devshell.legacyPackages.mkShell {
            name = "dotfiles";
            commands = extra.shellCommands;
            env = extra.shellEnv;
            packages = with pkgs; [
              inputs'.ragenix.packages.default # provide agenix CLI within flake shell
              config.treefmt.build.wrapper # treewide formatter
              nil # nix ls
              alejandra # nix formatter
              git # flakes require git, and so do I
              glow # markdown viewer
              statix # lints and suggestions
              deadnix # clean up unused nix code
              # some python stuff for waybar scripting
              (python311.withPackages (p: with p; [requests]))
            ];
          };

        # configure treefmt
        treefmt = {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            black.enable = true;
            deadnix.enable = false;
            shellcheck.enable = true;
            shfmt = {
              enable = true;
              indent_size = 4;
            };
          };
        };
      };

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    });
}
# see also: https://github.com/notashelf/nyx

