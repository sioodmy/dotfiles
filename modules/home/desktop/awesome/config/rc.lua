-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
require("awful.autofocus")
-- Widget and layout library
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/init.lua")

local bling = require("modules.bling")

require("error")
require("config")
require("binds")
require("rules")
require("signals")
require("widgets")
