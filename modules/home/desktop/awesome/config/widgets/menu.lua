local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local hotkeys_popup = require("awful.hotkeys_popup")

myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

powermenu = {
    { "Shutdown", "shutdown" },
    { "Reboot", "reboot" },
    { "Suspend", "hibernate" },
}
local margin = wibox.container.margin

mymainmenu = awful.menu({ items = { { "Search", "sh -c \"" .. search .. "\" &", beautiful.search_icon },
    { "Awesome", myawesomemenu, beautiful.awesome_icon },
    { "Terminal", terminal, beautiful.term_icon },
    { "File browser", files, beautiful.files_icon },
    { "Power", powermenu },
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
    menu = mymainmenu })
mymainmenu = awful.menu({
	items = {
		{ "Search", 'sh -c "' .. search .. '" &', beautiful.search_icon },
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		{ "Terminal", terminal, beautiful.term_icon },
		{ "File browser", files, beautiful.files_icon },
		{ "Power", powermenu },
	},
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
