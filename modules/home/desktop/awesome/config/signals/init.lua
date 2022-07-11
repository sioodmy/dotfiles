local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

pcall(require, "signals.battery")
pcall(require, "signals.brightness")
pcall(require, "signals.volume")

client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

local margin = wibox.container.margin
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )
    awful.titlebar(c, { position = 'left' }):setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        {
            buttons = buttons,
            layout = wibox.layout.flex.vertical
        },
        {
            {
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.stickybutton(c),
                spacing = dpi(7),
                layout  = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.vertical
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
-- }}}
