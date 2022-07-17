local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local bling = require("modules.bling")
local dpi = beautiful.xresources.apply_dpi
local margin = wibox.container.margin
local gfs = require("gears.filesystem")
local config_dir = gfs.get_configuration_dir()
local color = require("gears.color")

function rounded(round)
	return function(cr, w, h)
		return gears.shape.rounded_rect(cr, w, h, round)
	end
end

local clock = wibox.widget({
	widget = wibox.widget.textclock,
	format = "%H\n%M",
	align = "center",
	valign = "center",
	font = beautiful.clock_font,
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)
	-- Each screen has its own tag table.
	awful.tag({ "", "", "", "", "" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	bling.widget.tag_preview.enable({
		show_client_content = false, -- Whether or not to show the client content
		x = 10, -- The x-coord of the popup
		y = 10, -- The y-coord of the popup
		scale = 0.25, -- The scale of the previews compared to the screen
		honor_padding = false, -- Honor padding when creating widget size
		honor_workarea = false, -- Honor work area when creating widget size
		placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
			awful.placement.top_left(c, {
				margins = {
					top = 30,
					left = 30,
				},
			})
		end,
		background_widget = wibox.widget({ -- Set a background image (like a wallpaper) for the widget
			image = beautiful.wallpaper,
			horizontal_fit_policy = "fit",
			vertical_fit_policy = "fit",
			widget = wibox.widget.imagebox,
		}),
	})
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 12,
			layout = wibox.layout.flex.horizontal,
		},
		buttons = taglist_buttons,
	})
	local systray = wibox.widget.systray()
	systray:set_base_size(24)

	local volume_icon = wibox.widget({
		font = beautiful.icon_font_name .. "18",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local volume_widget = wibox.widget({
		{ volume_icon, right = dpi(2), widget = wibox.container.margin },
		max_value = 100,
		min_value = 0,
		value = 80,
		thickness = 2,
		start_angle = math.pi * 3 / 2,
		rounded_edge = true,
		bg = beautiful.bg_normal,
		colors = { beautiful.green },
		widget = wibox.container.arcchart,
	})

	awesome.connect_signal("signal::volume", function(vol, muted)
		local val = tonumber(vol) or 0

		local vol_icon = ""

		if val >= 77 and val <= 100 then
			vol_icon = ""
		elseif val >= 20 and val < 77 then
			vol_icon = ""
		else
			vol_icon = ""
		end

		if muted == 1 then
			vol_icon = "婢"
		end

		volume_widget.value = val

		volume_icon.markup = "<span foreground='" .. beautiful.green .. "'>" .. vol_icon .. "</span>"
	end)

	local launcher = wibox.widget({
		{
			{
				{
					widget = awful.widget.button({

						image = color.recolor_image(config_dir .. "theme/assets/icons/ghost.png", beautiful.bg_normal),
						buttons = {
							awful.button({}, 1, nil, function()
								awful.spawn("rofi -show drun")
							end),
						},
					}),
				},
				widget = wibox.container.margin,
				top = 7,
				bottom = 7,
				left = 7,
				right = 7,
			},
			widget = wibox.container.background,
			shape = rounded(10),
			bg = beautiful.blue,
		},
		widget = wibox.container.margin,

		top = 10,
		bottom = 10,
		left = 10,
		right = 10,
	})

	local network = wibox.widget({
		{
			id = "icon",
			align = "center",
			valign = "center",
			font = "Material Design Icons 20",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.align.vertical,
	})

	awful.widget.watch(
		[[sh -c "
		nmcli g | rg -q connected
		"]],
		5,
		function(_, _, _, _, code)
			local icon
			if code == 0 then
				icon = "󰤨"
			else
				icon = "󰤭"
			end
			network.icon.markup = "<span foreground='" .. beautiful.blue .. "'>" .. icon .. "</span>"
		end
	)

	local network_widget = wibox.widget({

		{
			widget = network,
		},
		widget = wibox.container.margin,
		top = 7,
		bottom = 7,
		left = 10,
		right = 10,
	})

	local battery_icon = wibox.widget({
		font = beautiful.icon_font_name .. "12",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local battery_bar = wibox.widget({
		max_value = 100,
		min_value = 0,
		value = 80,
		color = beautiful.light,
		background_color = beautiful.bg_focus,
		shape = rounded(10),
		bar_shape = rounded(10),
		widget = wibox.widget.progressbar,
	})

	local battery_widget = wibox.widget({
		{
			{
				battery_bar,
				direction = "east",
				forced_height = 100,
				widget = wibox.container.rotate,
			},
			battery_icon,
			layout = wibox.layout.stack,
		},
		widget = wibox.container.margin,
		top = 10,
		bottom = 10,
		left = 10,
		right = 10,
		visible = false,
	})

	awesome.connect_signal("signal::battery", function(percentage, state, vis)
		local value = percentage or 10

		local bat_icon = ""

		if value >= 0 and value <= 15 then
			bat_icon = ""
		elseif value > 15 and value <= 20 then
			bat_icon = ""
		elseif value > 20 and value <= 30 then
			bat_icon = ""
		elseif value > 30 and value <= 40 then
			bat_icon = ""
		elseif value > 40 and value <= 50 then
			bat_icon = ""
		elseif value > 50 and value <= 60 then
			bat_icon = ""
		elseif value > 60 and value <= 70 then
			bat_icon = ""
		elseif value > 70 and value <= 80 then
			bat_icon = ""
		elseif value > 80 and value <= 90 then
			bat_icon = ""
		elseif value > 90 and value <= 100 then
			bat_icon = ""
		end

		-- if charging
		if state == 1 then
			bat_icon = ""
		end

		battery_bar.value = value

		battery_icon.markup = "<span foreground='" .. beautiful.fg_normal .. "'>" .. bat_icon .. "</span>"

		battery_widget.visible = vis
	end)

	local bright_icon = wibox.widget({
		font = beautiful.icon_font_name .. "14",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local bright_widget = wibox.widget({

		{ bright_icon, right = dpi(1), widget = wibox.container.margin },
		max_value = 100,
		min_value = 0,
		value = 80,
		thickness = 2,
		start_angle = math.pi * 3 / 2,
		rounded_edge = true,
		bg = beautiful.bg_focus,
		colors = { beautiful.yellow },
		visible = true,
		widget = wibox.container.arcchart,
	})

	awesome.connect_signal("signal::brightness", function(percentage)
		local val = tonumber(percentage) or 0

		local bri_icon = ""

		if val >= 77 and val <= 100 then
			bri_icon = ""
		elseif val >= 20 and val < 77 then
			bri_icon = ""
		else
			bri_icon = ""
		end

		bright_widget.value = val
		bright_widget.visible = visible
		bright_icon.markup = "<span foreground='" .. beautiful.yellow .. "'>" .. bri_icon .. "</span>"
	end)

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "left",
		screen = s,
		strech = false,
		restrict_workarea = true,
		margins = {
			left = beautiful.useless_gap * 2,
			top = beautiful.useless_gap,
			bottom = beautiful.useless_gap,
		},
		width = 55,
		height = awful.screen.focused().workarea.height - beautiful.useless_gap * 4,
	})
	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.vertical,
		direction = "east",
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.vertical,
			launcher,
			network_widget,
			margin(volume_widget, 12, 12, 7, 7),
			margin(bright_widget, 12, 12, 7, 7),
		},
		{
			layout = wibox.container.rotate,
			direction = "west",
			s.mytaglist,
		},

		{ -- Right widgets
			layout = wibox.layout.fixed.vertical,
			battery_widget,
			margin(clock, 7, 7, 7, 7),
			margin(s.mylayoutbox, 15, 15, 0, 15),
		},
	})
end)
