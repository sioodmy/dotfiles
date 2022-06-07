local wk = require('whichkey_setup')

local keymap = {
  l = {
    f = "Find files",
    g = "Live grep",
    b = "Switch buffers",
    o = "Old files",
    H = "Help tags",
  },

  t = {
    k = "Change vertical to horizontal",
    h = "Change horizontal to vertical",
  },

  j = "Switch to left buffer",
  k = "Switch to right buffer",
  f = "Refresh filetree",
  n = "Find file in tree",
  z = "Zen mode",
  s = "Save file",

}

wk.register_keymap('leader', keymap)
