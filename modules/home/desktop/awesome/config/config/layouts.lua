local awful = require("awful")
local bling = require("modules.bling")

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    bling.layout.centered,
    bling.layout.mstab,
    bling.layout.horizontal,
    bling.layout.equalarea,
    bling.layout.deck,
}
