#!/bin/sh

per="$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')"


case $1 in 
    "*") command="" ;;
    "up") brightnessctl set +20% > /dev/null;;
    "down") brightnessctl set 20%- > /dev/null;;
    [0-9]*) 
        int=$(printf '%.0f' $1)
        brightnessctl set "$int%" > /dev/null
        ;;
esac

echo $per
