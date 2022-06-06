local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")



-- Set header

dashboard.section.header.val = {
  [[                                                                              ]],
  [[                                    ██████                                    ]],
  [[                                ████▒▒▒▒▒▒████                                ]],
  [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
  [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
  [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
  [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
  [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
  [[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
  [[                        ██      ██      ████      ████                        ]],
  [[                                                                              ]],
  [[                                                                              ]],
}

dashboard.section.header.opts = {
  position = "center",
  hl = "SpecialKey"
}


-- Set menu
dashboard.section.buttons.val = {
  dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
  dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),
  dashboard.button( "f", "  > Live grep", ":Telescope live_grep<CR>"),
  dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
  dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}


dashboard.section.footer.type = "text"
dashboard.section.footer.val = "coding is hard"

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
autocmd FileType alpha setlocal nofoldenable
]])
