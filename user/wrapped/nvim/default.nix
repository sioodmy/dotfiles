{
  pkgs,
  theme,
  ...
}: let
  inherit (builtins) attrValues;

  nvfetcher = builtins.mapAttrs (name: value:
    pkgs.vimUtils.buildVimPlugin {
      inherit name;
      inherit (value) src;
    }) (pkgs.callPackages ./_sources/generated.nix {});

  luatheme =
    if theme.nvim.enable
    then ''

      vim.cmd[[colorscheme ${theme.nvim.name}]]

      ${theme.nvim.configExtra}
    ''
    else ''

      require('base16-colorscheme').setup({
          base00 = '#${theme.base00}', base01 = '#${theme.base01}', base02 = '#${theme.base02}', base03 = '#${theme.base03}',
          base04 = '#${theme.base04}', base05 = '#${theme.base05}', base06 = '#${theme.base06}', base07 = '#${theme.base07}',
          base08 = '#${theme.base08}', base09 = '#${theme.base09}', base0A = '#${theme.base0A}', base0B = '#${theme.base0B}',
          base0C = '#${theme.base0C}', base0D = '#${theme.base0D}', base0E = '#${theme.base0E}', base0F = '#${theme.base0F}',
      })

    '';

  lua = pkgs.writeText "init.lua" (luatheme + builtins.readFile ./init.lua);

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    customRC = ''
      source ${./init.vim}
      :luafile ${lua}
    '';

    plugins =
      (attrValues nvfetcher)
      ++ (attrValues {
        inherit
          (pkgs.vimPlugins)
          lualine-nvim
          nvim-web-devicons
          gitsigns-nvim
          vim-fugitive
          indent-blankline-nvim-lua
          nvim-autopairs
          neoformat
          neo-tree-nvim
          comment-nvim
          nvim-colorizer-lua
          which-key-nvim
          markview-nvim
          lsp_lines-nvim
          undotree
          vim-speeddating
          luasnip
          vim-startuptime
          telescope-nvim
          harpoon
          alpha-nvim
          zen-mode-nvim
          sniprun
          vim-table-mode
          trouble-nvim
          nvim-cokeline
          fidget-nvim
          nvim-notify
          # Language support
          nvim-lspconfig
          nvim-cmp
          friendly-snippets
          cmp-cmdline
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          tailwind-tools-nvim
          nui-nvim
          plenary-nvim
          ;
      })
      ++ [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        theme.nvim.package
      ];
  };
in
  pkgs.symlinkJoin {
    name = "nvim-wrapped";
    paths =
      [
        (pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig)

        pkgs.nodePackages.typescript-language-server
      ]
      ++ attrValues {
        inherit
          (pkgs)
          gopls
          prettierd
          go
          pyright
          python3
          nil
          rust-analyzer
          alejandra
          vscode-langservers-extracted
          emmet-language-server
          bash-language-server
          zls
          clang-tools
          shellcheck
          cargo
          tailwindcss-language-server
          cargo-tauri
          trunk
          nixd
          stylua
          # required for my goofy ahh plugin :3
          libsixel
          ;
      };
  }
