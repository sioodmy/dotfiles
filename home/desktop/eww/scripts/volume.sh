#!/bin/bash

# Credits: bidule#9472

case $1 in 
    "*") command="" ;;
    "up") command="--allow-boost -i 5" ;;
    "down") command="--allow-boost -d 5" ;;
    "toggle") command="-t" ;;
    [0-9]*) 
        int=$(printf '%.0f' $1)
        command="--set-volume $int"
        ;;
esac

[ -n "$command" ] && pamixer $command 
mute=$(pamixer --get-mute)
volume="$(pamixer --get-volume)"
if [ "$mute" = "true" ]; then
      icon="婢"
      class="muted"
else 
      volume="$volume"
      class="nomuted"
      if [[ "$volume" -gt 100 ]]; then
            class="loud"
            icon="墳"
      elif [[ "$volume" -gt 66 ]]; then
            icon="墳"
      elif [[ "$volume" -gt 33 ]]; then
            icon="奔"
      elif [[ "$volume" -gt 0 ]]; then 
            icon="奄"
      else 
            icon="婢"
      fi
fi

echo "{\"content\": \"$volume\", \"icon\": \"$icon\", \"class\": \"$class\"}"
