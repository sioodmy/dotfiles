local servers = {
	"pyright",
	"nil_ls",
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

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

require("rust-tools").setup()
