{ pkgs, lib, config, ... }:

let
  catppuccin-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "catppuccin-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "406fdf2f2d2372df52d503e9f7bef96d89901c9f";
      sha256 = "17b07krgc9pzqhmwls2d50xbiqs4fgzmdi61qrz1v5n0bgs011mr";
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

  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-small dvisvgm dvipng wrapfig amsmath ulem hyperref capt-of booktabs
      etoolbox polski xcolor xetex fontspec euenc unicode-math;
  });

in {
  # Language servers
  home.packages = with pkgs; [
    rnix-lsp # Nix
    pyright # Python
    rust-analyzer # Rust
    gopls # Go
    sumneko-lua-language-server # Lua
    dart # Dart
    pandoc # For notes
    texlab tex # LaTeX
    nodePackages.typescript-language-server # Typescript
    nodePackages.vscode-langservers-extracted # HTML, CSS, JavaScript
    nodePackages.bash-language-server # Bash
    ccls
    cmake # C/C++
  ];

  # Ascii art
  home.file.".config/nvim/asciiart".source = ./asciiart;

  # Snippets 
  home.file.".vsnip/rust.json".source = ./snips/rust.json;
  home.file.".vsnip/pandoc.json".source = ./snips/pandoc.json;
  home.file.".vsnip/c.json".source = ./snips/c.json;
  home.file.".vsnip/cpp.json".source = ./snips/cpp.json;
  home.file.".vsnip/lua.json".source = ./snips/lua.json;
  home.file.".vsnip/shell.json".source = ./snips/shell.json;

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    package = pkgs.neovim-nightly;

    plugins = with pkgs.vimPlugins; [
      vim-flutter
      indent-blankline-nvim
      emmet-vim
      yuck-nvim
      vim-pandoc-syntax
      vim-pandoc
      vim-vsnip-integ
    {
      plugin = dashboard-nvim;
      config = ''
        let g:dashboard_default_executive = 'telescope'
        let g:dashboard_preview_file = "~/.config/nvim/asciiart"
        let g:dashboard_preview_command = 'cat'
        let g:dashboard_preview_file_height = 5
        let g:dashboard_preview_file_width = 43
        let g:indentLine_fileTypeExclude = ['dashboard']

      '';
    }
    {
      plugin = vim-vsnip;
      config = ''
        imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
        smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
        imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
        smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        nmap        s   <Plug>(vsnip-select-text)
        xmap        s   <Plug>(vsnip-select-text)
        nmap        S   <Plug>(vsnip-cut-text)
        xmap        S   <Plug>(vsnip-cut-text)

      '';
    }
    {
      plugin = telescope-nvim;
      config = ''
                  map <C-f> :Telescope find_files <CR>
                  map <C-n> :Telescope live_grep <CR>
                  lua << EOF
          local present, telescope = pcall(require, "telescope")

          if not present then
             return
          end

          local default = {
             defaults = {
                vimgrep_arguments = {
                   "rg",
                   "--color=never",
                   "--no-heading",
                   "--with-filename",
                   "--line-number",
                   "--column",
                   "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                   horizontal = {
                      prompt_position = "top",
                      preview_width = 0.55,
                      results_width = 0.8,
                   },
                   vertical = {
                      mirror = false,
                   },
                   width = 0.87,
                   height = 0.80,
                   preview_cutoff = 120,
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                use_less = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
             },
          }

          local M = {}
          M.setup = function(override_flag)
             if override_flag then
                default = require("core.utils").tbl_override_req("telescope", default)
             end

             telescope.setup(default)

             local extensions = { "themes", "terms" }

             pcall(function()
                for _, ext in ipairs(extensions) do
                   telescope.load_extension(ext)
                end
             end)
          end

          return M
          EOF
      '';
    }
    {
      plugin = catppuccin-nvim;
      config = ''
          colorscheme catppuccin
      '';
    }
    {
      plugin = rust-tools-nvim;
      config = ''
          lua require('rust-tools').setup({})
      '';
    }
    {
      plugin = nvim-tree-lua;
      config = ''
                    map <C-y> :NvimTreeToggle <CR>
                  lua << EOF
                    require'nvim-tree'.setup {}
                    local present, nvimtree = pcall(require, "nvim-tree")

          if not present then
             return
          end

          local g = vim.g

          g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
          g.nvim_tree_git_hl = 0
          g.nvim_tree_highlight_opened_files = 0
          g.nvim_tree_indent_markers = 1
          g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

          g.nvim_tree_show_icons = {
             folders = 1,
             files = 1,
             git = 1,
          }

          g.nvim_tree_icons = {
             default = "",
             symlink = "",
             git = {
                deleted = "",
                ignored = "◌",
                renamed = "➜",
                staged = "✓",
                unmerged = "",
                unstaged = "✗",
                untracked = "★",
             },
             folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
             },
          }

          local default = {
             filters = {
                dotfiles = false,
             },
             disable_netrw = true,
             hijack_netrw = true,
             ignore_ft_on_setup = { "dashboard" },
             auto_close = true,
             open_on_tab = false,
             hijack_cursor = true,
             hijack_unnamed_buffer_when_opening = false,
             update_cwd = true,
             update_focused_file = {
                enable = true,
                update_cwd = false,
             },
             view = {
                allow_resize = false,
                side = "left",
                width = 25,
                hide_root_folder = true,
             },
             git = {
                enable = false,
                ignore = false,
             },
          }

          local M = {}

          M.setup = function(override_flag)
             if override_flag then
                default = require("core.utils").tbl_override_req("nvim_tree", default)
             end
             nvimtree.setup(default)
          end

          return M
          EOF
      '';
    }
    {
      plugin = nvim-lspconfig;
      config = ''
              lua << EOF
                require'lspconfig'.rnix.setup {}
                require'lspconfig'.pyright.setup {}
                require'lspconfig'.dartls.setup{}
                require'lspconfig'.tsserver.setup{}
                require'lspconfig'.rust_analyzer.setup{}
                require'lspconfig'.gopls.setup{}
                require'lspconfig'.ccls.setup{}
                require'lspconfig'.bashls.setup{}
                require'lspconfig'.sumneko_lua.setup{}
                require'lspconfig'.cmake.setup{}
                local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          require'lspconfig'.texlab.setup{
          filetypes = {"tex", "bib", "markdown", "pandoc"},
          }
          require'lspconfig'.html.setup {
          capabilities = capabilities,
          }
          EOF

      '';
    }
    { plugin = nvim-web-devicons; }
    {
      plugin = nvim-compe;
      config = ''
          lua << EOF
          require'compe'.setup {
          enabled = true;
          autocomplete = true;
          debug = false;
          min_length = 1;
          preselect = 'enable';
          throttle_time = 80;
          source_timeout = 200;
          incomplete_delay = 400;
          max_abbr_width = 100;
          max_kind_width = 100;
          max_menu_width = 100;
          documentation = false;

          source = {
          path = true;
          buffer = true;
          nvim_lsp = true;
          treesitter = true;
          };
          }

          local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
          end
          _G.tab_complete = function()
          if vim.fn.pumvisible() == 1 then
          return t "<C-n>"
          else
          return t "<S-Tab>"
          end
          end

          vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
          vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
          EOF
      '';
    }
    {
      plugin = nvim-treesitter;
      config = ''
            lua << EOF
            local present, ts_config = pcall(require, "nvim-treesitter.configs")

          if not present then
          return
          end

          local default = {
          ensure_installed = {
          "lua",
          "rust",
          "c",
          "python",
          "html",
          "css",
          "nix",
          "javascript",
          "vim",
          },
          highlight = {
          enable = true,
          use_languagetree = true,
          },
          }

          local M = {}
          M.setup = function(override_flag)
          if override_flag then
          default = require("core.utils").tbl_override_req("nvim_treesitter", default)
          end
          ts_config.setup(default)
          end

            return M
          EOF
      '';
    }
    {
      plugin = bufferline-nvim;
      config = ''
          lua require('bufferline').setup{}
      '';
    }
    {
      plugin = pears-nvim;
      config = ''
          lua require "pears".setup()
      '';
    }
    {
      plugin = nvim-colorizer-lua;
      config = ''
          lua require "colorizer".setup()
      '';
    }
    {
      plugin = lspkind-nvim;
      config = ''
          lua << EOF
                    require('lspkind').init({
                    mode = 'symbol',

                      symbolmap = {
                        Text = "",
                        Method = "",
                    Function = "",
                    Constructor = "",
                    Field = "ﰠ",
                    Variable = "",
                    Class = "ﴯ",
                    Interface = "",
                    Module = "",
                    Property = "ﰠ",
                    Unit = "塞",
                    Value = "",
                    Enum = "",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "פּ",
                    Event = "",
                    Operator = "",
                    TypeParameter = ""
                  },
                    })
          EOF
      '';
    }
    {
      plugin = lualine-nvim;
      config = ''
          lua << EOF
          require('lualine').setup {
          options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
          always_divide_middle = true,
          },
          sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
          },
          inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
          },
          tabline = {},
          extensions = {}
          }
          EOF
      '';

    }
    {
      plugin = suda-vim;
      config = ''
          let g:suda_smart_edit = 1
      '';
    }
    vim-nix
  ];

  extraConfig = ''
    map I :! pandoc --pdf-engine xelatex  -V geometry=margin=1in -V fontsize=12pt -V mainfont="Comfortaa" -V monofont="JetBrains Mono NL" % -o $(echo % \| sed 's/md$/pdf/g') & disown <CR><CR>
    map S :! zathura $(echo % \| sed 's/md$/pdf/') & disown <CR><CR>
    lua << EOF
    local opt = vim.opt
    opt.lazyredraw = true;
    opt.shell = "zsh"
    opt.shadafile = "NONE"

    -- Colors
    opt.termguicolors = true

    -- Undo files
    opt.undofile = true

    -- Indentation
    opt.smartindent = true
    opt.tabstop = 4
    opt.softtabstop = 4
    opt.shiftwidth = 4
    opt.shiftround = true
    opt.expandtab = true
    opt.scrolloff = 3

    -- Set clipboard to use system clipboard
    opt.clipboard = "unnamedplus"

    -- Use mouse
    opt.mouse = "a"

    -- Nicer UI settings
    opt.cursorline = true
    opt.relativenumber = true
    opt.number = true

    -- Get rid of annoying viminfo file
    opt.viminfo = ""
    opt.viminfofile = "NONE"

    -- Miscellaneous quality of life
    opt.ignorecase = true
    opt.ttimeoutlen = 5
    opt.compatible = false
    opt.hidden = true
    opt.shortmess = "atI"
    opt.wrap = true
    opt.backup = false
    opt.writebackup = false
    opt.errorbells = false
    opt.swapfile = false
    opt.showmode = false
    opt.spell = false
    EOF
  '';
};
}
