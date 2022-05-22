local null_ls = require("null-ls")
local builtins = null_ls.builtins

local sources = {

  -- Formatter
  builtins.formatting.clang_format,
  builtins.formatting.dart_format,
  builtins.formatting.eslint_d,
  builtins.formatting.rustfmt,
  builtins.formatting.gofumpt,
  builtins.formatting.yapf,
  builtins.formatting.shfmt.with({
    extra_args = { "-i", "2", "-ci", "-sr" },
  }),
  builtins.formatting.stylua.with({
    condition = function(utils)
      return utils.root_has_file(".stylua.toml") or utils.root_has_file("stylua.toml")
    end,
  }),

  -- Diagnostics
  builtins.diagnostics.chktex,
  builtins.diagnostics.codespell.with({
    condition = function(utils)
      return utils.root_has_file("setup.cfg") or utils.root_has_file(".codespellrc")
    end,
  }),
  builtins.diagnostics.flake8,
  -- builtins.diagnostics.hadolint,
  builtins.diagnostics.markdownlint,
  builtins.diagnostics.shellcheck,
  -- builtins.diagnostics.pylint,

  --Testing
  builtins.code_actions.shellcheck,
}

null_ls.setup({
  debounce = 500,
  log = {
    enable = false,
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>sf",
      "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>",
      { noremap = true, silent = true }
    )
  end,
  sources = sources,
})
