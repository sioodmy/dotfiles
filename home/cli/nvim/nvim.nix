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
    programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
        {
            plugin = telescope-nvim;
            config = ''
                map <C-f> :Telescope find_files <CR>
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
              lua require'lspconfig'.rnix.setup{}
            '';
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
            plugin = indent-blankline-nvim;
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

    extraConfig = '' lua << EOF
    '' + builtins.readFile ./config.lua ''
    EOF
    '';
    };
}
