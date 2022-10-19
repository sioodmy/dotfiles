{ pkgs, lib, config, inputs, ... }:

with lib;
let
  cfg = config.modules.programs.vim;
  catppuccin-nvim-git = pkgs.vimUtils.buildVimPlugin {
    name = "catppuccin-nvim";
    src = inputs.catppuccin-nvim;

  };

  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-small dvisvgm dvipng fontspec euenc unicode-math;
  });
  mkpandoc = pkgs.writeShellScriptBin "mkpandoc" ''
    #!/bin/bash
    INPUT=$1
    OUTPUT="$(basename "$INPUT" .md).pdf"
    pandoc "$INPUT" \
    	--pdf-engine xelatex \
    	-V 'geometry:margin=1in' \
    	-V 'mainfont:DejaVu Serif' \
    	-V 'sansfont:DejaVu Sans' \
    	-V 'fontsize=12pt' \
    	-o "$OUTPUT"

    if [ "$2" = "-o" ]; then
    	zathura "$OUTPUT" &
    fi

  '';

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
      tex
      mkpandoc
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
        vim-nix
        null-ls-nvim
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
        vim-pandoc-syntax
        luasnip
        nvim-tree-lua
        cmp_luasnip
        cmp-pandoc-references
        gitsigns-nvim
        lsp_lines-nvim
        auto-save-nvim
        nvim-notify
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
