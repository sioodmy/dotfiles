#!/bin/sh

bat=/sys/class/power_supply/BAT0/
per="$(cat "$bat/capacity")"

if [ "$per" -gt "90" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "80" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "70" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "60" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "50" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "40" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "30" ]; then
	icon=""
    class="battery"
elif [ "$per" -gt "20" ]; then
	icon=""
    class="battery-low"
elif [ "$per" -gt "10" ]; then
	icon=""
    class="battery-low"
	notify-send -u critical "Battery Low" "Connect Charger"
elif [ "$per" -gt "0" ]; then
	icon=""
    class="battery-low"
	notify-send -u critical "Battery Low" "Connect Charger"
else
        icon=""
fi

if [ $(cat "$bat/status") = "Charging" ]; then
    class="battery-charging"
fi

echo "{\"percent\": \"$per\", \"icon\": \"$icon\", \"class\": \"$class\"}"
