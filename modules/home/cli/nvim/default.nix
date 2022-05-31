{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.cli.nvim;
  alpha-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "alpha-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "4781fcfea5ddc1a92d41b32dc325132ed6fce7a8";
      sha256 = "GA+fIfVlHOllojGyErYGC0+zyYTl9rOxendqOgApJw4=";
    };
  };

  yuck-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "yuck-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "elkowar";
      repo = "yuck.vim";
      rev = "6dc3da77c53820c32648cf67cbdbdfb6994f4e08";
      sha256 = "lp7qJWkvelVfoLCyI0aAiajTC+0W1BzDhmtta7tnICE=";
    };
  };

  autosave-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "autosave-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Pocco81";
      repo = "AutoSave.nvim";
      rev = "3d342d6fcebeede15b6511b13a38a522c6f33bf8";
      sha256 = "1tAYnd4/hGgG2NG8n9hZi9zWM+v1OTh0YBlG8kEZeXI=";
    };
  };

  whichkey-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "whichkey-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "which-key.nvim";
        rev = "bd4411a2ed4dd8bb69c125e339d837028a6eea71";
        sha256= "UoV9H3oVJL1BPmuG+/eU4cG1s7thOrcrPyat9npBxm0=";
      };
    };

  headlines-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "headlines-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "lukas-reineke";
        repo = "headlines.nvim";
        rev = "347ef0371451d9bfbf010c6743fb74997b5b9a80";
        sha256 = "XgXSKBLLVCu9hfHzk9Xro+dooV4XaZJnFsVz+/wzyaQ=";
      };
    };

  org-bullets = pkgs.vimUtils.buildVimPlugin {
      name = "org-bullets";
      src = pkgs.fetchFromGitHub {
        owner = "akinsho";
        repo = "org-bullets.nvim";
        rev = "8dc2e25088ffa10029157c9aaede7d79f3fc75b1";
        sha256 = "OtjjuNYGRD38i/356rej0ps4VRSPYv1yBKtNwGkmGxI=";
      };
    };

  prettier-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "prettier-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "MunifTanjim";
        repo = "prettier.nvim";
        rev = "9fb2b9795ccb29081e3afcd41b9138a27cba2ec2";
        sha256 = "cgHHXg+DqBvSrMyC5A9GhbvFwatIMPgaAg/fkCIyr7w=";
      };
    };

in {
  options.modules.cli.nvim = { enable = mkEnableOption "nvim"; };


  config = mkIf cfg.enable {

    # Link configuration
    home.file.".config/nvim/lua".source = ./lua;
    home.file.".config/nvim/config.lua".source = ./config.lua;

    # Language servers / dev tools
    home.packages = with pkgs; [
      rnix-lsp nixfmt # Nix
      pyright # Python
      rust-analyzer clippy # Rust
      gopls # Go
      sumneko-lua-language-server # Lua
      dart flutter # Dart/flutter things
      pandoc # For notes
      nodejs nodePackages.typescript nodePackages.typescript-language-server # Typescript
      nodePackages.vscode-langservers-extracted # HTML, CSS, JavaScript
      nodePackages.yarn
      nodePackages.bash-language-server nodePackages.node2nix# Bash
      ccls cmake # C/C++
      nodePackages.prettier # prettier code UwU
    ];

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      package = pkgs.neovim-nightly;

      plugins = with pkgs.vimPlugins; [
        indent-blankline-nvim
        stabilize-nvim
        nvim-colorizer-lua
        autosave-nvim
        plenary-nvim
        vim-flutter
        vim-nix
        nord-nvim
        nvim-autopairs
        nvim-lspconfig
        prettier-nvim
        lspsaga-nvim
        orgmode
        org-bullets
        vim-table-mode
        headlines-nvim
        nvim-treesitter
        nvim-ts-autotag
        toggleterm-nvim
        nvim-ts-rainbow
        friendly-snippets
        luasnip
        lsp_signature-nvim
        telescope-nvim
        aerial-nvim
        todo-comments-nvim
        TrueZen-nvim
        bufferline-nvim
        alpha-nvim
        neoscroll-nvim
        nvim-whichkey-setup-lua
        yuck-nvim
        nvim-notify
        lualine-nvim
        nvim-web-devicons
        emmet-vim
        nvim-tree-lua
        nvim-cmp
        cmp-nvim-lsp
        cmp-spell
        cmp-latex-symbols
        cmp-emoji
        lspkind-nvim
        vim-commentary
        null-ls-nvim
        gitsigns-nvim
      ];

      extraConfig = ''
        colorscheme nord
        luafile ~/.config/nvim/config.lua
      '';
    };
  };
}
