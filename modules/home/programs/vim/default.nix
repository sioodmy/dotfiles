{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.programs.minivim;
  articblush-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "articblush-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "articblush";
      repo = "articblush.nvim";
      rev = "4b80e05518fcfb7897ddc7fb50dc3b4603c6a27e";
      sha256 = "rmUriyzsltVEtvH1R65WkPR3RSeXr+vruFodN5ZBxV4=";
    };
  };

in {
  options.modules.programs.minivim = { enable = mkEnableOption "minivim"; };

  config = mkIf cfg.enable {
    home.file.".config/nvim/settings.lua".source = ./init.lua;

    home.packages = with pkgs; [
      rnix-lsp
      nixfmt # Nix
      sumneko-lua-language-server
      stylua # Lua
      uncrustify
      shellcheck
    ];

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        null-ls-nvim
        mini-nvim
        telescope-nvim
        lualine-nvim
        impatient-nvim
        articblush-nvim
        indent-blankline-nvim
        {
          plugin = nvim-lspconfig;
          config = ''
            lua << EOF
            require('lspconfig').rust_analyzer.setup{}
            require('lspconfig').sumneko_lua.setup{}
            require('lspconfig').rnix.setup{}
            require('lspconfig').zk.setup{}
            EOF
          '';
        }

      ];
      extraConfig = ''
        luafile ~/.config/nvim/settings.lua
      '';

    };

  };
}
