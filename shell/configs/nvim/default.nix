{
  pkgs,
  colors,
  ...
}: let
  nvfetcher = builtins.mapAttrs (name: value:
    pkgs.vimUtils.buildVimPlugin {
      inherit name;
      inherit (value) src;
    }) (pkgs.callPackages ./_sources/generated.nix {});

  theme = with colors; ''

    require('base16-colorscheme').setup({
        base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
        base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
        base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
        base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
    })

  '';

  lua = pkgs.writeText "init.lua" (theme + builtins.readFile ./init.lua);

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    customRC = ''
      source ${./init.vim}
      :luafile ${lua}
    '';

    plugins =
      (builtins.attrValues nvfetcher)
      ++ (with pkgs.vimPlugins; [
        lualine-nvim
        nvim-web-devicons
        gitsigns-nvim
        vim-fugitive
        indent-blankline-nvim-lua
        nvim-autopairs
        neoformat
        comment-nvim
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
        bufferline-nvim
        fidget-nvim
        nvim-notify

        # Language support
        nvim-lspconfig
        nvim-cmp
        cmp-cmdline
        cmp-nvim-lsp
        cmp-buffer
        cmp-path

        nvim-treesitter.withAllGrammars

        orgmode

        nui-nvim
        plenary-nvim
      ]);
  };
in {
  basePackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
  # mostly LSP related packages
  pathAdd = with pkgs; [
    gopls
    go
    nil
    rust-analyzer
    alejandra
    vscode-langservers-extracted
    bash-language-server
    clang-tools
    zls
    gleam
    nodePackages.typescript-language-server
    nodePackages.prettier
    shellcheck
    cargo
    nixd
    typst-lsp
    stylua
  ];
  renames = {
    "nvim" = "v";
  };
}
