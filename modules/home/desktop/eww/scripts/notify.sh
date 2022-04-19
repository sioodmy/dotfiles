#!/bin/bash

# Credits: druskus20

print_notification() {
  content=$(echo "$1" | tr '\n' ' ')
  echo "{\"show\": \"$2\", \"content\": \"$content\"}"
}

print_notification "" "false"
tiramisu -o '#summary' | while read -r line; do 
  eww update noti=false
  canberra-gtk-play -i message -d "notification"   
  print_notification "$line" "true"
  sleep 0.5
  eww update noti=true
  (sleep 10; eww update noti=false; print_notification "" "false") &
  pid="$!"
done


