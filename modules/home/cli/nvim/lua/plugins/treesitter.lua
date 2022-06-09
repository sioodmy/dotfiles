require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
    'typescript', 'vim', 'rust', 'org'
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  autotag = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
}
