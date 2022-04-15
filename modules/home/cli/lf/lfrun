#!/bin/sh
set -e

cleanup() {
    exec 3>&-
	rm "$FIFO_UEBERZUG"
}

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	lf "$@"
else
	[ ! -d "$HOME/.cache/lf" ] && mkdir --parents "$HOME/.cache/lf"
	export FIFO_UEBERZUG="$HOME/.cache/lf/ueberzug-$$"
	mkfifo "$FIFO_UEBERZUG"
	ueberzug layer -s <"$FIFO_UEBERZUG" -p json &
	exec 3>"$FIFO_UEBERZUG"
	trap cleanup EXIT
	lf "$@" 3>&-
fi
