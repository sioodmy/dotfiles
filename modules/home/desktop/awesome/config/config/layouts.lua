local awful = require("awful")
local bling = require("modules.bling")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	bling.layout.centered,
	bling.layout.mstab,
	bling.layout.horizontal,
	bling.layout.equalarea,
	bling.layout.deck,
}

bling.widget.tag_preview.enable({
	show_client_content = true,
	scale = 0.20,
	honor_workarea = true,
	honor_padding = true,
	placement_fn = function(c)
		awful.placement.bottom(c, {
			margins = {
				bottom = dpi(60),
			},
		})
	end,
	background_widget = wibox.widget({
		image = beautiful.wallpaper,
		horizontal_fit_policy = "fit",
		vertical_fit_policy = "fit",
		widget = wibox.widget.imagebox,
	}),
})
