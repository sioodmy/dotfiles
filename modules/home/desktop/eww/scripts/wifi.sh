#!/bin/sh

if nmcli g | rg -q "\bconnected\b"; then
    icon="󰤨"
    ssid=$(nmcli -t -f name connection show --active)
    if echo $ssid | rg -q "Wired"; then
        status="Connected via cable" 
    else
        status="Connected to ${ssid}"
    fi
else
    icon="󰤭"
    status="offline"
fi

printf "{\"icon\": \"${icon}\", \"status\": \"${status}\"}" 
