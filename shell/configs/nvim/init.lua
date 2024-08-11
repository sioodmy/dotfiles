vim.loader.enable()

vim.opt.termguicolors = true

require("incline").setup({})
require("fidget").setup({})
require("scope").setup({})

require("bufferline").setup({
	options = {
		right_mouse_command = nil,
		middle_mouse_command = "bdelete! %d",
		indicator = {
			style = " ",
		},
	},
})

local resession = require("resession")

resession.setup({
	autosave = {
		enabled = true,
		interval = 60,
		notify = true,
	},
	buf_filter = function(bufnr)
		local buftype = vim.bo[bufnr].buftype
		if buftype == "help" then
			return true
		end
		if buftype ~= "" and buftype ~= "acwrite" then
			return false
		end
		if vim.api.nvim_buf_get_name(bufnr) == "" then
			return false
		end
		return true
	end,
	extensions = { scope = {} },
})

local function get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Only load the session if nvim was started with no args
		if vim.fn.argc(-1) == 0 then
			resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save(get_session_name(), { dir = "dirsession", notify = false })
	end,
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[⠀⠀⠀⠀⠀⠀⢀⡤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⢀⡏⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⣀⠴⠋⠉⠉⡆⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠈⠉⠉⠙⠓⠚⠁⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⢀⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣄⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⡞⠀⠀⠀⠀⠀⠶⠀⠀⠀⠀⠀⠀⠦⠀⠀⠀⠀⠀⠸⡆⠀⠀⠀]],
	[[⢠⣤⣶⣾⣧⣤⣤⣀⡀⠀⠀⠀⠀⠈⠀⠀⠀⢀⡤⠴⠶⠤⢤⡀⣧⣀⣀⠀]],
	[[⠻⠶⣾⠁⠀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠀⣰⠋⠀⠀⠀⠀⠀⢹⣿⣭⣽⠇]],
	[[⠀⠀⠙⠤⠴⢤⡤⠤⠤⠋⠉⠉⠉⠉⠉⠉⠉⠳⠖⠦⠤⠶⠦⠞⠁⠀⠀ ]],
}
dashboard.section.header.opts.hl = "Keyword"
dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("n", "  Notebook", ":VimwikiIndex <CR>"),
	dashboard.button("c", "  Calendar", ":Calendar <CR>"),
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("g", "󰺄  Live grep", ":Telescope live_grep <CR>"),
	dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = "meoww :3"
dashboard.section.footer.opts.hl = "Keyword"

dashboard.config.opts.noautocmd = true

vim.cmd([[autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2]])

alpha.setup(dashboard.config)

require("gitsigns").setup({})

require("ibl").setup()

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
})

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	check_ts = true,
	enable_check_bracket_line = false,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				feedkey("<C-n>", "n")
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {
			"i",
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				feedkey("<C-p>", "n")
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {
			"i",
		}),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "path", option = { trailing_slash = true } },
		{ name = "treesitter" },
		{ name = "vimwiki-tags" },
		{ name = "orgmode" },
	}),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_lsp = require("lspconfig")

nvim_lsp.rnix.setup({
	capabilities = capabilities,
	autostart = true,
	cmd = { "nil" },
})
nvim_lsp.gopls.setup({
	capabilities = capabilities,
	autostart = true,
})

nvim_lsp.html.setup({
	capabilities = capabilities,
})
nvim_lsp.nixd.setup({})
nvim_lsp.tsserver.setup({})
nvim_lsp.cssls.setup({})
nvim_lsp.bashls.setup({})
nvim_lsp.clangd.setup({})
nvim_lsp.zls.setup({})
nvim_lsp.gleam.setup({})

local on_attach = function(client)
	require("completion").on_attach(client)
end

nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	additional_vim_regex_highlighting = false,
})

require("trouble").setup({})

vim.o.timeout = true
vim.o.timeoutlen = 500

local telescope = require("telescope")
telescope.setup({})
telescope.load_extension("harpoon")
telescope.load_extension("scope")

local orgmode = require("orgmode")
orgmode.setup({
	org_agenda_files = { "~/docs/notes/*.org" },
	org_default_notes_file = "~/docs/notes/Refile.org",
})
require("org-bullets").setup()

require("Comment").setup()

vim.filetype.add({
	filename = {
		[".envrc"] = "bash",
	},
})
