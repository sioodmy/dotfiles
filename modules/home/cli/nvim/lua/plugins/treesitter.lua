require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
}
