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
in
{

  # Language servers
  home.packages = with pkgs; [ 
    rnix-lsp 
    pyright 
    rust-analyzer 
    gopls
    emacs27Packages.lsp-dart 
    sumneko-lua-language-server
    nodePackages.typescript-language-server 
    nodePackages.vscode-langservers-extracted
    nodePackages.bash-language-server
  ];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        config = ''
        map <C-f> :Telescope find_files <C
        map <C-n> :Telescope live_grep <CR>
        '';
      }
      {
        plugin = catppuccin-nvim;
        config = ''
        colorscheme catppuccin
        '';
      }
      {
        plugin = nvim-tree-lua;
        config = ''
        lua << EOF
        require'nvim-tree'.setup {
          disable_netrw        = true,
          hijack_netrw         = true,
          open_on_setup        = false,
          ignore_ft_on_setup   = {},
          auto_close           = false,
          auto_reload_on_write = true,
          open_on_tab          = false,
          hijack_cursor        = false,
          update_cwd           = false,
          hijack_directories   = {
            enable = true,
            auto_open = true,
          },
          diagnostics = {
            enable = false,
            icons = {
              hint = "",
              info = "",
              warning = "",
              error = "",
            }
          },
          update_focused_file = {
            enable      = false,
            update_cwd  = false,
            ignore_list = {}
          },
          system_open = {
            cmd  = nil,
            args = {}
          },
          filters = {
            dotfiles = false,
            custom = {}
          },
          git = {
            enable = true,
            ignore = true,
            timeout = 500,
          },
          view = {
            width = 30,
            height = 30,
            hide_root_folder = false,
            side = 'left',
            auto_resize = false,
            mappings = {
              custom_only = false,
              list = {}
            },
            number = false,
            relativenumber = false,
            signcolumn = "yes"
          },
          trash = {
            cmd = "trash",
            require_confirm = true
          },
          actions = {
            change_dir = {
              global = false,
            },
            open_file = {
              quit_on_open = false,
            }
          }
        }
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
                require'lspconfig'.bashls.setup{}
                require'lspconfig'.sumneko_lua.setup{}
                local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          require'lspconfig'.html.setup {
          capabilities = capabilities,
          }
          EOF

        '';
      }
      {
        plugin = nvim-web-devicons;
      }
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
        plugin = vim-flutter;
      }
      {
        plugin = indent-blankline-nvim;
      }
      {
        plugin = emmet-vim;
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
