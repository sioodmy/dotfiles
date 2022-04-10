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
[ -n "$command" ] && pamixer --default-source $command 
mute=$(pamixer --default-source --get-mute)
volume="$(pamixer --default-source --get-volume)"
if [ "$mute" = "true" ]; then
      icon=" "
      class="micmuted"
else 
      volume="$volume"
      class="micnomuted"
      icon=" "
fi

echo "{\"content\": \"$volume\", \"icon\": \"$icon\", \"class\": \"$class\"}"
