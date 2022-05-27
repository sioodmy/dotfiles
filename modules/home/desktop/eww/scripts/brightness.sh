#!/bin/sh

if eww windows | rg -q "\*brightness"; then
    eww update bright-level="$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')"

    eww update bright-hidden=false
else
    eww close volume
    eww open brightness

    eww update bright-level="$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')"
    eww update bright-hidden=false
    sleep 2
    eww update bright-hidden=true
    sleep 1
    eww close brightness
fi
