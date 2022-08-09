-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local o = vim.o

require("impatient")
----------------------------------------------------------e
-- General ---------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options
opt.conceallevel = 2
opt.concealcursor = "nc"
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Set number
opt.relativenumber = true -- Relative number
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
opt.colorcolumn = "80" -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.cursorline = true -- Cursor line
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3 -- Set global statusline
opt.scrolloff = 8
opt.undofile = true
opt.fileencoding = "utf-8"
opt.conceallevel = 0
-----------------------------------------------------------
-- Neovide
-----------------------------------------------------------
g.neovide_cursor_vfx_mode = "railgun" -- neovide option
g.neovide_refresh_rate = 60
g.neovide_cursor_vfx_particle_lifetime = 1.2
g.neovide_cursor_vfx_particle_density = 7.0
g.neovide_cursor_vfx_particle_speed = 10.0
g.neovide_cursor_vfx_particle_phase = 1.5
g.neovide_cursor_vfx_particle_curl = 1.0
o.guifont = "monospace:h13"

-----------------------------------------------------------
-- Theme
-----------------------------------------------------------
-- Load the colorscheme
require("catppuccin").setup({
	term_colors = true,
})
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd([[colorscheme catppuccin]])
-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = false
opt.autoindent = true -- Autoindent new lines
g.user_emmet_leader_key = "<M-c>" -- Emmet key

vim.cmd([[
augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ set-spacing padding=15 margin=10
    au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0
augroup END
]])
-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 700 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append("sI")

-- Disable builtins plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
