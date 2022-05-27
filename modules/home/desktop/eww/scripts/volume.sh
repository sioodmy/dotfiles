#!/bin/sh

if eww windows | rg -q "\*volume"; then
    eww update volume-level=$(pamixer --get-volume)
    eww update volume-muted=$(pamixer --get-mute)
    eww update volume-hidden=false
else
    eww close brightness
    eww open volume

    eww update volume-level=$(pamixer --get-volume)
    eww update volume-muted=$(pamixer --get-mute)
    eww update volume-hidden=false
    sleep 2
    eww update volume-hidden=true
    sleep 1
    eww close volume
fi
