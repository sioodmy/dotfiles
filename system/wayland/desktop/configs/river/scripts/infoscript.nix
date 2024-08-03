{pkgs, ...}:
# Instead of bar (imagine wasting so much space on your screen)
# I use this script
pkgs.writeShellScriptBin "infoscript" ''
  #!/bin/sh

  VOL="$(${pkgs.pamixer}/bin/pamixer --get-volume)"
  BAT_TEXT=""

  if [[ -d /sys/class/power_supply/BAT0 ]]; then
      BAT="$(cat /sys/class/power_supply/BAT0/capacity)"
      BAT_STATUS="$(cat /sys/class/power_supply/BAT0/status)"
      BAT_TEXT="\nBattery is at <b>$BAT%</b> ($BAT_STATUS)"
  fi

  ${pkgs.libnotify}/bin/notify-send \
    -t 3000 \
    --hint=string:x-dunst-stack-tag:infoscript \
     --hint=string:synchronous:infoscript \
    "$(date +%H:%M)" \
    "$(date +"%a, <b>%d.%m</b>")$BAT_TEXT\nVolume <b>$VOL%</b>"

''
