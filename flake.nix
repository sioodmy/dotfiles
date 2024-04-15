{
  description = "My NixOS configuration";
  # https://dotfiles.sioodmy.dev

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        {
          config._module.args._inputs = inputs // {inherit (inputs) self;};
        }

        inputs.flake-parts.flakeModules.easyOverlay
        inputs.pre-commit-hooks.flakeModule
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

        pre-commit = {
          settings.excludes = ["flake.lock"];

          settings.hooks = {
            alejandra.enable = true;
            prettier.enable = true;
          };
        };
        devShells.default = let
          extra = import ./devShell;
        in
          inputs'.devshell.legacyPackages.mkShell {
            name = "dotfiles";
            commands = extra.shellCommands;
            env = extra.shellEnv;
            packages = with pkgs; [
              inputs'.agenix.packages.default # provide agenix CLI within flake shell
              inputs'.catppuccinifier.packages.cli
              config.treefmt.build.wrapper # treewide formatter
              nil # nix ls
              alejandra # nix formatter
              git # flakes require git, and so do I
              glow # markdown viewer
              statix # lints and suggestions
              deadnix # clean up unused nix code
              # some python stuff for waybar scripting
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
        images.iapetus =
          (self.nixosConfigurations.iapetus.extendModules
            {
              modules = ["${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-new-kernel-no-zfs-installer.nix"];
            })
          .config
          .system
          .build
          .sdImage;
      };
    });

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

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        nixpak.follows = "nixpak";
      };
    };

    # schizosearch = {
    #   url = "github:sioodmy/schizosearch";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-parts.follows = "flake-parts";
    #   };
    # };

    barbie = {
      url = "github:sioodmy/barbie";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    # a tree-wide formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccinifier = {
      url = "github:lighttigerXIV/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
# see also:
# - https://github.com/notashelf/nyx
# - https://github.com/fufexan/dotfiles/
# - https://github.com/n3oney/nixus
# (I love you guys)

