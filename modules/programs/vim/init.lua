local o = vim.opt
local g = vim.g

vim.g.mapleader = ","
require("impatient")

vim.cmd([[
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
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
map("n", "<C-f>", ":Telescope find_files <CR>", opts)
map("n", "<C-w>", ":NvimTreeToggle <CR>", opts)
map("n", "<leader>mp", ":!mkpandoc % & <CR><CR>", opts)
map("n", "<leader>mpo", ":!mkpandoc % -o & <CR><CR>", opts)
map("n", "<leader>t", ":NvimTreeToggle <CR>", opts)
map("n", "<C-s>", ":HopWord <CR>", opts)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("n", ";", ":", { noremap = true })
map("n", "[b", ":BufferLineCycleNext <CR> ", opts)
map("n", "]b", ":BufferLineCyclePrev <CR> ", opts)

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

local cmp = require("cmp")
local lspkind = require("lspkind")
lspkind.init({
	mode = "symbol",
	symbol_map = {
		Array = "",
		Boolean = "⊨",
		Class = "",
		Constructor = "",
		Key = "",
		Namespace = "",
		Null = "NULL",
		Number = "#",
		Object = "⦿",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "𝓐",
		TypeParameter = "",
		Unit = "",
	},
})

local servers = {
	"pyright",
	"rnix",
	"rust_analyzer",
	"tsserver",
	"gopls",
	"ccls",
	"bashls",
	"cmake",
	"html",
	"cssls",
	"dartls",
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 200,
		},
	})
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- snippets stuff
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
	s({ trig = "frac", dscr = "Fraction" }, {
		t("\\frac{"),
		i(1),
		t("}"),
		t("{"),
		i(2),
		t("}"),
		i(0),
	}),
	s({ trig = "sqrt", dscr = "Square root" }, {
		t("\\sqrt["),
		i(1),
		t("]"),
		t("{"),
		i(2),
		t("}"),
		i(0),
	}),
})

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
		}),
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "pandoc_references" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

vim.g.catppuccin_flavour = "frappe"
require("catppuccin").setup({
	styles = {
		keywords = { "bold" },
	},
})
vim.cmd([[colorscheme catppuccin]])

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣶⣿⣿⣿⣿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⠿⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠿⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⢸⣿⣿⠏⣠⣤⡄⣠⣤⡌⢿⣿⣿⣿⣿⡿⢁⣤⣄⢀⣤⣄⠹⣿⣿⡇⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⠸⣿⣿⠀⢿⣿⣿⣿⣿⡟⢸⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⡿⠀⣿⣿⠇⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⠀⢻⣿⣆⠀⠙⠿⠟⠋⢀⣾⣿⣿⣿⣿⣷⡀⠈⠻⡿⠋⠁⣰⣿⡟⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣶⣶⣶⣾⣿⣿⡿⠋⠙⢿⣿⣿⣷⣶⣶⣶⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣴⣧⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠙⠛⠙⠛⠛⠋⠛⠋⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  New File    ", ":enew<CR>"),
	dashboard.button("f", "  Find File   ", ":Telescope find_files<CR>"),
	dashboard.button("t", "  Find Text   ", ":Telescope live_grep<CR>"),
	dashboard.button("q", "  Quit        ", ":qa<CR>"),
}

local datetime = os.date(" %d-%m-%Y")

dashboard.section.footer.val = {
	datetime,
}

alpha.setup(dashboard.opts)

require("bufferline").setup({
	options = {
		mode = "tabs",
		show_close_icon = false,
		separator_style = "thick",
	},
})
require("nvim-web-devicons").setup({})

require("toggleterm").setup({
	size = 10,
	open_mapping = [[<c-\>]],
	shading_factor = 2,
	shell = "tmux",
	direction = "float",
	float_opts = {
		border = "curved",
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})
local npairs = require("nvim-autopairs")

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
npairs.add_rules({
	Rule("$", "$", { "tex", "latex", "markdown", "markdown.pandoc" })
		-- don't add a pair if the next character is %
		:with_pair(cond.not_after_regex("%%"))
		-- don't add a pair if  the previous character is xxx
		:with_pair(cond.not_before_regex("xxx", 3))
		-- don't move right when repeat character
		:with_move(cond.none())
		-- don't delete if the next character is xx
		:with_del(cond.not_after_regex("xx"))
		-- disable adding a newline when you press <cr>
		:with_cr(cond.none()),
}, {
	Rule("$$", "$$", { "tex", "latex", "markdown", "markdown.pandoc" }):with_pair(function(opts)
		print(vim.inspect(opts))
		if opts.line == "aa $$" then
			-- don't add pair on that line
			return false
		end
	end),
})

require("hop").setup()
require("colorizer").setup()

local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#303446',
  fg       = '#c6d0f5',
  yellow   = '#e5c890',
  cyan     = '#85c1dc',
  darkblue = '#ca9ee6',
  green    = '#a6d189',
  orange   = '#ef9f76',
  violet   = '#f4b8e4',
  magenta  = '#eebebe',
  blue     = '#8caaee',
  red      = '#e78284',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
})

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

ins_left({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = "#ffffff", gui = "bold" },
})

-- Add components to right sections
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳 ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = { "alpha" },
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	view = {
		adaptive_size = true,
		side = "left",
		width = 25,
		hide_root_folder = true,
	},
	git = {
		enable = false,
		ignore = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		highlight_git = false,
		highlight_opened_files = "none",

		indent_markers = {
			enable = false,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},

			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
})
