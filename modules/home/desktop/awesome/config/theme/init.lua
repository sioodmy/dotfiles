---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local gears = require("gears")
local machi = require("modules.layout-machi")
local color = require("gears.color")
local themes_path = gfs.get_themes_dir()
local config_dir = gfs.get_configuration_dir()
local theme = {}

function rounded(round)
	return function(cr, w, h)
		return gears.shape.rounded_rect(cr, w, h, round)
	end
end

theme.font = "Roboto 13"
theme.icon_font_name = "JetBrainsMono Nerd Font Mono "
theme.clock_font = "Work Sans Bold 19"
theme.bg_normal = "#24273a"
theme.light = "#494d64"
theme.overlay = "#8087a2"
theme.bg_container = "#363a4f"
theme.bg_focus = "#363a4f"
theme.bg_urgent = "#ed8796"
theme.bg_minimize = "#1e2030"
theme.green = "#a6da95"
theme.red = "#ed8796"
theme.yellow = "#eed49f"
theme.blue = "#8aadf4"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#cad3f5"
theme.fg_focus = theme.fg_normal

theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

theme.useless_gap = dpi(6)
theme.border_width = dpi(0)
theme.border_normal = "#5b6078"
theme.border_focus = "#8aadf4"
theme.border_marked = "#f5a97f"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.hotkeys_modifiers_fg = "#8aadf4"
theme.hotkeys_description_fg = "#cad3f5"
-- Generate taglist squares:
theme.wibar_height = 35
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_fg_urgent = theme.green
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_focus = theme.border_focus
theme.taglist_fg_empty = "#939ab7"
theme.taglist_font = "JetBrainsMono Nerd Font Mono 16"
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

theme.notification_font = "Roboto 15"
theme.notification_fg = theme.fg_normal
theme.notification_bg = theme.bg_normal
theme.notification_opacity = 1
theme.notification_margin = 50
theme.notification_icon_size = 100
theme.notification_spacing = 10
theme.notification_shape = rounded(8)
theme.notification_max_width = 500
theme.notification_border_width = 1
theme.notification_border_color = theme.color_darker

theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(35)
theme.menu_border_width = dpi(15)
theme.menu_border_color = theme.bg_normal
theme.menu_width = dpi(200)

theme.mstab_tabbar_style = "modern"

theme.window_switcher_widget_bg = "#1e2030" -- The bg color of the widget
theme.window_switcher_widget_border_width = 3 -- The border width of the widget
theme.window_switcher_widget_border_radius = 10 -- The border radius of the widget
theme.window_switcher_widget_border_color = "#363a4f" -- The border color of the widget
theme.window_switcher_clients_spacing = 20 -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 150 -- The width of one client widget
theme.window_switcher_client_height = 250 -- The height of one client widget
theme.window_switcher_client_margins = 10 -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10 -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10 -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200 -- The width of one title
theme.window_switcher_name_font = "sans 11" -- The font of all titles
theme.window_switcher_name_normal_color = theme.fg_normal -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.blue -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center" -- How to vertically align the one icon
theme.window_switcher_icon_width = 20 -- The width of one icon
-- Task list

theme.task_preview_widget_border_radius = 5
theme.task_preview_widget_bg = "#24273a"
theme.task_preview_widget_border_color = "#363a4f"
theme.task_preview_widget_border_width = 3
theme.task_preview_widget_margin = 30
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.layout_machi = machi.get_icon()
local dot = config_dir .. "theme/assets/icons/dot.png"
theme.titlebar_close_button_normal = color.recolor_image(dot, theme.red)
theme.titlebar_close_button_focus = theme.titlebar_close_button_normal

theme.titlebar_minimize_button_normal = color.recolor_image(dot, "#eed49f")
theme.titlebar_minimize_button_focus = theme.titlebar_minimize_button_normal

theme.titlebar_ontop_button_normal_inactive = color.recolor_image(dot, "#f5bde6")
theme.titlebar_ontop_button_focus_inactive = theme.titlebar_ontop_button_normal_inactive
theme.titlebar_ontop_button_normal_active = color.recolor_image(dot, "#c6a0f6")
theme.titlebar_ontop_button_focus_active = theme.titlebar_ontop_button_normal_active

theme.titlebar_sticky_button_normal_inactive = color.recolor_image(dot, "#f4dbd6")
theme.titlebar_sticky_button_focus_inactive = theme.titlebar_sticky_button_normal_inactive
theme.titlebar_sticky_button_normal_active = color.recolor_image(dot, "#b8c0e0")
theme.titlebar_sticky_button_focus_active = theme.titlebar_sticky_button_focus_active

theme.titlebar_floating_button_normal_inactive = color.recolor_image(dot, "#7dc4e4")
theme.titlebar_floating_button_focus_inactive = theme.titlebar_floating_button_normal_inactive
theme.titlebar_floating_button_normal_active = color.recolor_image(dot, "#b7bdf8")
theme.titlebar_floating_button_focus_active = theme.titlebar_floating_button_normal_active

theme.titlebar_maximized_button_normal_inactive = color.recolor_image(dot, theme.green)
theme.titlebar_maximized_button_focus_inactive = theme.titlebar_maximized_button_normal_inactive
theme.titlebar_maximized_button_normal_active = theme.titlebar_maximized_button_normal_inactive
theme.titlebar_maximized_button_focus_active = theme.titlebar_maximized_button_normal_inactive

theme.wallpaper = config_dir .. "theme/wallpaper.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = color.recolor_image(themes_path .. "default/layouts/floatingw.png", theme.fg_normal)
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = color.recolor_image(themes_path .. "default/layouts/tilew.png", theme.fg_normal)
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.files_icon = config_dir .. "theme/assets/icons/files.png"
theme.search_icon = config_dir .. "theme/assets/icons/search.png"
theme.term_icon = config_dir .. "theme/assets/icons/term.png"
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
