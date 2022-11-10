#!/bin/sh
if hyprctl getoption misc:enable_swallow | rg -q "int: 1"; then
	hyprctl keyword misc:enable_swallow false >/dev/null &&
		notify-send "Hyprland" "Turned off swallowing"
else
	hyprctl keyword misc:enable_swallow true >/dev/null &&
		notify-send "Hyprland" "Turned on swallowing"
fi
