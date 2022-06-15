#!/bin/sh

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## All windows are floating on desktop 5
FLOATING_DESKTOP_ID=$(bspc query -D -d '^5')

bspc subscribe node_add | while read -a msg ; do
   desk_id=${msg[2]}
   wid=${msg[4]}
   [ "$FLOATING_DESKTOP_ID" = "$desk_id" ] && bspc node "$wid" -t floating
done
