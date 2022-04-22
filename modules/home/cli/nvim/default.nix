{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.cli.nvim;
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
  options.modules.cli.nvim = { enable = mkEnableOption "nvim"; };

  config = mkIf cfg.enable {
    # Language servers
    home.packages = with pkgs; [
      rnix-lsp # Nix
      pyright # Python
      rust-analyzer # Rust
      gopls # Go
      sumneko-lua-language-server # Lua
      dart # Dart
      pandoc # For notes
      tex # LaTeX
      texlab # LaTeX language server
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
        stabilize-nvim
        vim-pandoc-syntax
        vim-pandoc
        vim-vsnip-integ
        {
          plugin = vim-signify;
          config = ''
            set updatetime=100
          '';
        }
        {
          plugin = dashboard-nvim;
          config = ''
            lua << EOF
            local g = vim.g
            g.indentLine_fileTypeExclude = { 'dashboard' }
            g.dashboard_session_directory = '~/.config/nvim/.sessions'
            g.dashboard_default_executive ='telescope'
            g.dashboard_custom_section = {
            a = {description = {"  Find File"}, command = "Telescope find_files"},
            b = {description = {"  Recents"}, command = "Telescope oldfiles"},
            c = {description = {"  Find Word"}, command = "Telescope live_grep"},
            d = {description = {"  New File"}, command = "DashboardNewFile"},
            e = {description = {"  Bookmarks"}, command = "Telescope marks"},
            i = {description = {"  Exit"}, command = "exit"}
            }

            g.dashboard_custom_footer = {'Coding is hard'}
            g.dashboard_custom_header =  {
            "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
            "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
            "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
            "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
            "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
            "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
            "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
            " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
            " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
            "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
            "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
            }

            vim.cmd [[
            augroup dashboard_au
            autocmd! * <buffer>
            autocmd User dashboardReady let &l:stl = 'Dashboard'
            augroup END
            ]]
            EOF

          '';
        }
        {
          plugin = vim-vsnip;
          config = ''
            lua << EOF
            vim.defer_fn(function()
            vim.cmd [[
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
            ]]
            end, 70)
            EOF

          '';
        }
        {
          plugin = telescope-nvim;
          config = ''
                    lua << EOF
                    vim.cmd [[
                    map <C-f> :Telescope find_files <CR>
                    map <C-n> :Telescope live_grep <CR>
                    ]]
                    vim.defer_fn(function()
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
            end, 70)
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
          plugin = auto-session;
          config = ''
            lua << EOF
            vim.defer_fn(function()
            require('auto-session').setup({
                log_level = 'info',
                auto_session_enable_last_session = true,
                auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
                auto_session_enabled = true,
                auto_save_enabled = true,
                auto_restore_enabled = false,
                auto_session_suppress_dirs = nil,
                auto_session_use_git_branch = nil,
                bypass_session_save_file_types = nil
            })
            end, 70)
            EOF
          '';
        }
        {
          plugin = nvim-tree-lua;
          config = ''
                      map <C-y> :NvimTreeToggle <CR>
                    lua << EOF
            vim.defer_fn(function()
            require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
              auto_reload_on_write = true,
              disable_netrw = false,
              hide_root_folder = false,
              hijack_cursor = true,
              hijack_netrw = true,
              hijack_unnamed_buffer_when_opening = false,
              ignore_buffer_on_setup = false,
              open_on_setup = false,
              open_on_setup_file = false,
              open_on_tab = false,
              sort_by = "name",
              update_cwd = false,
              view = {
              width = 30,
                height = 30,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
              mappings = {
                custom_only = false,
                list = {
                },
            },
            },
            renderer = {
              indent_markers = {
               enable = false,
               icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
                },
            },
            icons = {
              webdev_colors = true,
            },
            },
            hijack_directories = {
            enable = true,
            auto_open = true,
            },
            update_focused_file = {
            enable = false,
            update_cwd = false,
            ignore_list = {},
            },
            ignore_ft_on_setup = {},
            system_open = {
            cmd = nil,
            args = {},
            },
            diagnostics = {
            enable = false,
            show_on_dirs = false,
            icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
            },
            },
            filters = {
            dotfiles = false,
            custom = {},
            exclude = {},
            },
            git = {
            enable = true,
            ignore = true,
            timeout = 400,
            },
            actions = {
            use_system_clipboard = true,
            change_dir = {
            enable = true,
            global = false,
            },
            open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
            },
            },
            },
            },
            trash = {
            cmd = "trash",
            require_confirm = true,
            },
            log = {
            enable = false,
            truncate = false,
            types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
            },
            },
            } -- END
            end, 70)
            EOF
          '';
        }
        {
          plugin = nvim-lspconfig;
          config = ''
                lua << EOF
                vim.defer_fn(function()
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
            end, 70)
            EOF

          '';
        }
        { plugin = nvim-web-devicons; }
        {
          plugin = nvim-compe;
          config = ''
            lua << EOF
            vim.defer_fn(function()
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
            end, 70)
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
            lua << EOF
            vim.defer_fn(function()
            require "pears".setup(function(conf)
              conf.remove_pair_on_inner_backspace(false)
              conf.remove_pair_on_outer_backspace(false)
            end)
            end, 70)
            EOF
          '';
        }
        {
          plugin = nvim-colorizer-lua;
        }
        {
          plugin = lspkind-nvim;
          config = ''
            lua << EOF
            vim.defer_fn(function()
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
              end, 70)
            EOF
          '';
        }
        {
          plugin = lualine-nvim;
          config = ''
            lua << EOF
            require('lualine').setup {
            options = {
            disabled_filetypes = {'dashboard'},
            icons_enabled = true,
            theme = 'auto',
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
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
        lua << EOF
        local opt = vim.opt
        opt.cursorline = true
        opt.relativenumber = true
        opt.number = true

        vim.defer_fn(function()
        vim.cmd [[
        map I :! pandoc --pdf-engine xelatex  -V geometry=margin=1in -V fontsize=12pt -V mainfont="Comfortaa" -V monofont="JetBrains Mono NL" % -o $(echo % \| sed 's/md$/pdf/g') & disown <CR><CR>
        map S :! zathura $(echo % \| sed 's/md$/pdf/') & disown <CR><CR>
        ]]
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
        end, 70)
        EOF
      '';
    };
  };
}
