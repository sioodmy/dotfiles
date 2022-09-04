{ pkgs, lib, config, inputs, ... }:

with lib;
let cfg = config.modules.programs.vim;
in {
  options.modules.programs.vim = { enable = mkEnableOption "vim"; };

  config = mkIf cfg.enable {
    home.file.".config/nvim/settings.lua".source = ./init.lua;

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
      nodePackages.jsonlint # JSON
      nodePackages.typescript
      nodePackages.typescript-language-server # Typescript
      nodePackages.vscode-langservers-extracted # HTML, CSS, JavaScript
      nodePackages.yarn
      nodePackages.bash-language-server
      nodePackages.node2nix # Bash
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
        nord-nvim
        lspkind-nvim
        nvim-lspconfig
        vim-surround
        bufferline-nvim
        alpha-nvim
        toggleterm-nvim
        orgmode
        nvim-autopairs
        nvim-colorizer-lua
        (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            pkgs.tree-sitter-org
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
      extraConfig = ''
        luafile ~/.config/nvim/settings.lua
      '';

    };

  };
}
