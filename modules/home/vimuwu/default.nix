{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.programs.vimuwu;
in {
  options.modules.programs.vimuwu = {enable = mkEnableOption "vimuwu";};

  config = mkIf cfg.enable {
    xdg.configFile."nvim".source = ./nvim;

    home.packages = with pkgs; [
      nil
      sumneko-lua-language-server
      stylua # Lua
      uncrustify
      shellcheck
      # Rust nightly
      (rust-bin.selectLatestNightlyWith
        (toolchain: toolchain.minimal))
      # rust-analyzer
      alejandra # Nix
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
      texlab
    ];

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      withRuby = false;
      withNodeJs = false;
      withPython3 = false;
      plugins = with pkgs.vimPlugins; [
        lsp_lines-nvim
        vim-nix
        nvim-ts-autotag
        cmp-nvim-lsp-signature-help
        cmp-buffer
        comment-nvim
        lsp_lines-nvim
        null-ls-nvim
        vim-fugitive
        friendly-snippets
        luasnip
        rust-tools-nvim
        crates-nvim
        vim-illuminate
        cmp_luasnip
        nvim-cmp
        impatient-nvim
        indent-blankline-nvim
        nvim-tree-lua
        telescope-nvim
        nvim-web-devicons
        cmp-nvim-lsp
        cmp-path
        catppuccin-nvim
        lspkind-nvim
        nvim-lspconfig
        hop-nvim
        alpha-nvim
        nvim-autopairs
        nvim-colorizer-lua
        gitsigns-nvim
        nvim-ts-rainbow
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
            tree-sitter-go
            tree-sitter-java
            tree-sitter-typescript
            tree-sitter-javascript
            tree-sitter-cmake
            tree-sitter-comment
            tree-sitter-http
            tree-sitter-regex
            tree-sitter-dart
            tree-sitter-make
            tree-sitter-html
            tree-sitter-css
            tree-sitter-latex
            tree-sitter-bibtex
            tree-sitter-php
            tree-sitter-sql
            tree-sitter-zig
            tree-sitter-dockerfile
          ]))
      ];
    };
  };
}
