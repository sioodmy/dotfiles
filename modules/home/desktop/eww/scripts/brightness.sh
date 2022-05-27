#!/bin/sh

if eww windows | rg -q "\*bright"; then
    eww update volume-level="$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')"

    eww update volume-hidden=false
else

    eww open volume

    eww update volume-level="$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')"
    eww update volume-hidden=false
    sleep 2
    eww update volume-hidden=true
    sleep 1
    eww close volume
fi
