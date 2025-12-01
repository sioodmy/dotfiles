{pkgs, ...}:
let
  inherit (pkgs) writeShellScriptBin;
in
[
  (writeShellScriptBin "dunst-bar" ''
#!/usr/bin/env bash

BATTERY_LEVEL="$(</sys/class/power_supply/macsmc-battery/capacity)"
BATTERY_STATUS="$(</sys/class/power_supply/macsmc-battery/status)"

BATTERY_LABEL="$BATTERY_LEVEL%"

if [ $BATTERY_STATUS = 'Charging' ]; then
  BATTERY_LABEL="$BATTERY_LABEL 󱐋"
fi

TIME="$(date +%H:%M)"

dunstify -t 550 -h string:x-canonical-private-synchronous:bar "$TIME" "$BATTERY_LABEL"

  '')
]
