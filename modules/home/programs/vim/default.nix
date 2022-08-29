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
      #      package = pkgs.neovim-nightly;
      vimAlias = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        null-ls-nvim
        neorg
        nvim-colorizer-lua
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
        vim-sayonara
      ];
      extraConfig = ''
        luafile ~/.config/nvim/settings.lua
      '';

    };

  };
}
