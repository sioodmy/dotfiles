local o = vim.opt
local g = vim.g

require("impatient")

-- Colorscheme
require("articblush").setup({
	italics = {
		code = true,
		comments = true,
	},
	nvim_tree = {
		contrast = true,
	},
})
-- Autocmds
vim.cmd([[
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
autocmd FileType nix setlocal shiftwidth=4
]])

-- Keybinds
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

require("telescope").setup()
require("indent_blankline").setup()
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-n>", ":Telescope live_grep <CR>", opts)
map("n", "<C-f>", ":Telescope find_files <CR>", opts)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("n", ";", ":", { noremap = true })

g.mapleader = " "

-- Performance
o.lazyredraw = true
o.shell = "zsh"
o.shadafile = "NONE"

-- Colors
o.termguicolors = true

-- Undo files
o.undofile = true

-- Indentation
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4
o.shiftround = true
o.expandtab = true
o.scrolloff = 3

-- Set clipboard to use system clipboard
o.clipboard = "unnamedplus"

-- Use mouse
o.mouse = "a"

-- Nicer UI settings
o.cursorline = true
o.relativenumber = true
o.number = true

-- Miscellaneous quality of life
o.ignorecase = true
o.ttimeoutlen = 5
o.hidden = true
o.shortmess = "atI"
o.wrap = false
o.backup = false
o.writebackup = false
o.errorbells = false
o.swapfile = false
o.showmode = false
o.laststatus = 3
o.pumheight = 6
o.splitright = true
o.splitbelow = true
o.completeopt = "menuone,noselect"

local null_ls = require("null-ls")

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	-- add your sources / config options here
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.formatting.uncrustify,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.diagnostics.tsc,
		null_ls.builtins.formatting.shfmt,
	},
	on_attach = on_attach,
	-- you can reuse a shared lspconfig on_attach callback here
	debug = false,
})

null_ls.builtins.formatting.rustfmt.with({
	extra_args = { "--edition=2021" },
})

require("mini.comment").setup({
	mappings = {
		comment = "gc",
		comment_line = "gcc",
		textobject = "gc",
	},
	hooks = {
		pre = function() end,
		post = function() end,
	},
})

require("mini.pairs").setup({
	-- In which modes mappings from this `config` should be created
	modes = { insert = true, command = false, terminal = false },

	-- Global mappings. Each right hand side should be a pair information, a
	-- table with at least these fields (see more in |MiniPairs.map|):
	-- - <action> - one of 'open', 'close', 'closeopen'.
	-- - <pair> - two character string for pair to be used.
	-- By default pair is not inserted after `\`, quotes are not recognized by
	-- `<CR>`, `'` does not insert pair after a letter.
	-- Only parts of tables can be tweaked (others will use these defaults).
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
		["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
	},
})

local starter = require("mini.starter")
starter.setup({
	items = {
		starter.sections.telescope(),
		starter.sections.recent_files(10, false),
		starter.sections.sessions(5, true),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.aligning("center", "center"),
	},
	footer = "coding is hard",
})

require("lualine").setup()
require("mini.completion").setup({})
require("mini.tabline").setup({})
