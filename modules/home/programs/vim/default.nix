{ pkgs, lib, config, inputs, ... }:

with lib;
let
  cfg = config.modules.programs.vim;
  neorg-telescope-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-telescope-nvim";
    src = inputs.neorg-telescope-nvim;
  };
in {
  options.modules.programs.vim = { enable = mkEnableOption "vim"; };

  config = mkIf cfg.enable {
    home.file.".config/nvim/init.lua".source = ./init.lua;

    home.packages = with pkgs; [
      rnix-lsp
      sumneko-lua-language-server
      stylua # Lua
      uncrustify
      shellcheck
      rust-analyzer
      rustfmt
      nixfmt # Nix
      gopls # go
      asmfmt
      ccls # cpp
      black # python
      shellcheck # bash
      shfmt
      nodejs
      nodePackages.pyright
      nodePackages.prettier
      nodePackages.stylelint
      nodePackages.jsonlint # JSON
      nodePackages.typescript-language-server # Typescript
      nodePackages.vscode-langservers-extracted # HTML, CSS, JavaScript
      nodePackages.yarn
      nodePackages.bash-language-server
      nodePackages.node2nix # Bash
      pandoc
      texlive.combined.scheme-basic
    ];

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      vimAlias = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        null-ls-nvim
        gruvbox-nvim
        telescope-nvim
        nvim-web-devicons
        vim-commentary
        lualine-nvim
        impatient-nvim
        indent-blankline-nvim
        nvim-cmp
        nvim-tree-lua
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        catppuccin-nvim
        lspkind-nvim
        nvim-lspconfig
        vim-surround
        hop-nvim
        bufferline-nvim
        alpha-nvim
        toggleterm-nvim
        nvim-autopairs
        nvim-colorizer-lua
        zen-mode-nvim
        neorg-telescope-nvim
        cmp-latex-symbols
        vim-pandoc
        vim-pandoc-syntax
        ultisnips
        cmp-pandoc-references
        (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            tree-sitter-python
            tree-sitter-c
            tree-sitter-nix
            tree-sitter-cpp
            tree-sitter-rust
            tree-sitter-toml
            tree-sitter-json
            tree-sitter-lua
            tree-sitter-bash
            tree-sitter-go
            tree-sitter-java
            tree-sitter-typescript
            tree-sitter-javascript
            tree-sitter-cmake
            tree-sitter-comment
            tree-sitter-http
            tree-sitter-markdown
            tree-sitter-regex
            tree-sitter-dart
            tree-sitter-make
            tree-sitter-latex
            tree-sitter-bibtex
            tree-sitter-php
            tree-sitter-sql
            tree-sitter-zig
            tree-sitter-dockerfile
          ]))
      ];
      #      extraConfig = builtins.readFile ./init.lua;
      # extraConfig = ":luafile ${./init.lua}";

    };

  };
}
