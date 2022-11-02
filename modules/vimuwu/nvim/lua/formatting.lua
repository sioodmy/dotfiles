local null_ls = require("null-ls")
require("gitsigns").setup()
require("colorizer").setup()

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

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
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.uncrustify,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.rustfmt.with({
			extra_args = { "--edition=2021" },
		}),
		null_ls.builtins.formatting.nixfmt.with({
			extra_args = { "-w=80" },
		}),
	},
	on_attach = on_attach,
	-- you can reuse a shared lspconfig on_attach callback here
	debug = false,
})
