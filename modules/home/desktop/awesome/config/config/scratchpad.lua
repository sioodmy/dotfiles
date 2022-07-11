local bling = require("modules.bling")
local rubato = require("modules.rubato") -- Totally optional, only required if you are using animations.

-- These are example rubato tables. You can use one for just y, just x, or both.
-- The duration and easing is up to you. Please check out the rubato docs to learn more.
local anim_y = rubato.timed {
    pos = -1000,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true -- This option must be set to true.
}

term_scratch = bling.module.scratchpad {
    command                 = "kitty --class spad", -- How to spawn the scratchpad
    rule                    = { instance = "spad" }, -- The rule that the scratchpad will be searched by
    sticky                  = false, -- Whether the scratchpad should be sticky
    autoclose               = true, -- Whether it should hide itself when losing focus
    floating                = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
    geometry                = { x = 360, y = 90, height = 900, width = 1200 }, -- The geometry in a floating state
    reapply                 = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
    dont_focus_before_close = false, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
    rubato                  = { y = anim_y } -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
}
