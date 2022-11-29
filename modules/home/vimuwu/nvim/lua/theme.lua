vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
	transparent_background = true,
	integrations = {
		nvimtree = { enabled = true, transparent_panel = false, show_root = true },
		gitsigns = true,
		telescope = true,
		treesitter = true,
		hop = true,
	},
})
vim.cmd.colorscheme("catppuccin")
