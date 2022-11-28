#!/bin/sh

off=" Shutdown"
reboot=" Reboot"
cancel=" Cancel"

sure="$(printf '%s\n%s\n%s' "${off}" "${reboot}" "${cancel}" |
	rofi -dmenu -p ' Are you sure?')"

if [ "${sure}" = "${off}" ]; then
	doas shutdown now
elif [ "${sure}" = "${reboot}" ]; then
	doas reboot now
fi
