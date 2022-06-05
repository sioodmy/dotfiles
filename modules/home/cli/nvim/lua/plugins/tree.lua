require'nvim-tree'.setup {
  open_on_setup = true,
  --open_on_setup_file = true,
  open_on_tab = true,
  update_cwd = true,
  view = { width = 32 },
  renderer = {
    highlight_opened_files = "1",
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
