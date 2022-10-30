local tree = require("nvim-treesitter.configs")

require("nvim-ts-autotag").setup()

tree.setup({
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
