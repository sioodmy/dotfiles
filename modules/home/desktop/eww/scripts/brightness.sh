#!/bin/sh

brightness="$(xrandr --verbose | grep 'Brightness' | tr -d 'Brightness:  ' | tr -d '[:blank:]')"

[ -n $1 ] && xrandr --output eDP-1 --brightness $1 && echo nigger

echo "{\"content\": \"$volume\", \"icon\": \"$icon\", \"class\": \"$class\"}"
