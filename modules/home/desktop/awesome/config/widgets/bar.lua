local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local bling = require("modules.bling")
local dpi = beautiful.xresources.apply_dpi
local margin = wibox.container.margin

local clock = wibox.widget({
		widget = wibox.widget.textclock,
		format = "%H\n%M",
		align = "center",
		valign = "center",
		font = "Work Sans Bold 19",
	})
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(

                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))




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
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
bling.widget.tag_preview.enable {
    show_client_content = false,  -- Whether or not to show the client content
    x = 10,                       -- The x-coord of the popup
    y = 10,                       -- The y-coord of the popup
    scale = 0.25,                 -- The scale of the previews compared to the screen
    honor_padding = false,        -- Honor padding when creating widget size
    honor_workarea = false,       -- Honor work area when creating widget size
    placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.top_left(c, {
            margins = {
                top = 30,
                left = 30
            }
        })
    end,
    background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget
        image = beautiful.wallpaper,
        horizontal_fit_policy = "fit",
        vertical_fit_policy   = "fit",
        widget = wibox.widget.imagebox
    }
}
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout = {
          spacing = 12,
          layout = wibox.layout.flex.horizontal
        },
        buttons = taglist_buttons
      }
local systray = wibox.widget.systray()
systray:set_base_size(24)
      -- Create a tasklist widget
local common = require("awful.widget.common")
local function mylistupdate(w, buttons, label, data, objects)
    common.list_update(w, buttons, label, data, objects)
    w:set_max_widget_size(100)
end
bling.widget.task_preview.enable {
    x = 20,                    -- The x-coord of the popup
    y = 20,                    -- The y-coord of the popup
    height = 200,              -- The height of the popup
    width = 200,               -- The width of the popup
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.top_left(c, {
            margins = {
                top = beautiful.useless_gap * 2,
                left = 60,
            }
        })
    end,
    -- Your widget will automatically conform to the given size due to a constraint container.
    widget_structure = {
        {
            {
                {
                    id = 'icon_role',
                    widget = awful.widget.clienticon, -- The client icon
                },
                {
                    id = 'name_role', -- The client name / title
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.flex.horizontal
            },
            widget = wibox.container.margin,
            margins = 5
        },
        {
            id = 'image_role', -- The client preview
            resize = false,
            valign = 'center',
            halign = 'center',
            widget = wibox.widget.imagebox,
        },
        layout = wibox.layout.fixed.vertical
    }
}
s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    layout   = {
        spacing_widget = {
            {
                forced_width  = 5,
                forced_height = 24,
                thickness     = 0,
                widget        = wibox.widget.separator
            },
            valign = 'center',
            halign = 'center',
            widget = wibox.container.place,
        },
        spacing = 1,
        layout  = wibox.layout.fixed.vertical
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            wibox.widget.base.make_widget(),
            forced_height = 5,
            id            = 'background_role',
            widget        = wibox.container.background,
        },
        {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            margins = 10,
            widget  = wibox.container.margin
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            self:get_children_by_id('clienticon')[1].client = c

            -- BLING: Toggle the popup on hover and disable it off hover
            self:connect_signal('mouse::enter', function()
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        true, c)
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        false, c)
                end)
        end,
        layout = wibox.layout.align.vertical,
    },
}

local volume_icon = wibox.widget {
    font = beautiful.icon_font_name .. "18",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local volume_widget = wibox.widget {
    {volume_icon, right = dpi(2), widget = wibox.container.margin},
    max_value = 100,
    min_value = 0,
    value = 80,
    thickness = 3,
    start_angle = math.pi * 3 / 2,
    rounded_edge = true,
    bg = beautiful.bg_normal,
    colors = {beautiful.green},
    widget = wibox.container.arcchart
}

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

    if muted == 1 then vol_icon = "婢" end

    volume_widget.value = val

    volume_icon.markup = "<span foreground='" .. beautiful.fg_normal .. "'>" ..
                             vol_icon .. "</span>"
end)

local bright_icon = wibox.widget {
    font = beautiful.icon_font_name .. "14",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local bright_widget = wibox.widget {
    {bright_icon, right = dpi(1), widget = wibox.container.margin},
    max_value = 100,
    min_value = 0,
    value = 80,
    thickness = 2,
    start_angle = math.pi * 3 / 2,
    rounded_edge = true,
    bg = beautiful.bg_normal,
    colors = {beautiful.yellow},
    widget = wibox.container.arcchart
}

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

    bright_icon.markup = "<span foreground='" .. beautiful.yellow .. "'>" ..
                             bri_icon .. "</span>"
end)


      -- Create the wibox
      s.mywibox = awful.wibar({
        position = "left",
        screen = s,
        strech = false,
        restrict_workarea	= true,
        margins = {
          left = beautiful.useless_gap * 2,
          top = beautiful.useless_gap,
          bottom = beautiful.useless_gap,
        },
        width = 55,
        height = awful.screen.focused().workarea.height - beautiful.useless_gap * 4,
      })
      -- Add widgets to the wibox
      s.mywibox:setup {
        layout = wibox.layout.align.vertical,
        direction = "east",
        expand = "none",
        { -- Left widgets
        layout = wibox.layout.align.vertical,
        s.mytasklist,
        s.mypromptbox,
      },
      {
        layout = wibox.container.rotate,
        direction = "west",
      s.mytaglist,
    },

      { -- Right widgets
      layout = wibox.layout.fixed.vertical,
      margin(bright_widget, 12, 12, 5, 5),
      margin(volume_widget, 12, 12, 5, 5),
      margin(s.mylayoutbox, 15, 15, 15, 0),
      margin(clock, 5, 5, 10, 10)
    },

  }
end)
