local g = vim.g

g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_icons = { default = "" }
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
}

require'nvim-tree'.setup {
  open_on_setup = true,
  --open_on_setup_file = true,
  open_on_tab = true,
  update_cwd = true,
  view = { width = 32 },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  actions = {
    change_dir = { enable = false },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = true,
    custom = { 'node_modules', '.cache', '.bin' },
  },
}
