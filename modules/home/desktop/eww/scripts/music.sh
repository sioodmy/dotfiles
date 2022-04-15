#!/bin/bash
# scripts by adi1090x

## Get data
COVER="/tmp/music_cover.png"
MUSIC_DIR="$HOME/music"

## Get status
get_status() {
	if [[ "$(mpc status)" == *"[playing]"* ]]; then
		echo ""
	else
		echo "奈"
	fi
}

## Get song
get_song() {
	song=`mpc -f %title% current`
	if [[ -z "$song" ]]; then
		echo "Offline"
	else
		echo "$song" | awk '{gsub("[(][^)]*[)]","")}1' | cut -c-30
	fi	
}

## Get artist
get_artist() {
	artist=`mpc -f %artist% current`
	if [[ -z "$artist" ]]; then
		echo ""
	else
		echo "$artist"
	fi	
}

## Get time
get_time() {
	time=`mpc status | grep "%)" | awk '{print $4}' | tr -d '(%)'`
	if [[ -z "$time" ]]; then
		echo "0"
	else
		echo "$time"
	fi	
}
get_ctime() {
	ctime=`mpc status | grep "#" | awk '{print $3}' | sed 's|/.*||g'`
	if [[ -z "$ctime" ]]; then
		echo "0:00"
	else
		echo "$ctime"
	fi	
}
get_ttime() {
	ttime=`mpc -f %time% current`
	if [[ -z "$ttime" ]]; then
		echo "0:00"
	else
		echo "$ttime"
	fi	
}

## Get cover
get_cover() {
	ffmpeg -i "${MUSIC_DIR}/$(mpc current -f %file%)" "${COVER}" -y &> /dev/null
	STATUS=$?

	# Check if the file has a embbeded album art
	if [ "$STATUS" -eq 0 ];then
		echo "$COVER"
	else
		echo "images/music.png"
	fi
}

## Execute accordingly
if [[ "$1" == "--song" ]]; then
    get_song
    mpc idleloop | while read -r _; do
    	get_song
    done
elif [[ "$1" == "--artist" ]]; then
	get_artist
elif [[ "$1" == "--status" ]]; then
    get_status
    mpc idleloop | while read -r _; do
    	get_status
    done
elif [[ "$1" == "--time" ]]; then
	get_time
elif [[ "$1" == "--ctime" ]]; then
	get_ctime
elif [[ "$1" == "--ttime" ]]; then
	get_ttime
elif [[ "$1" == "--cover" ]]; then
	get_cover
    mpc idleloop | while read -r _; do
	    get_cover
    done
elif [[ "$1" == "--toggle" ]]; then
	mpc -q toggle
elif [[ "$1" == "--next" ]]; then
	{ mpc -q next; get_cover; }
elif [[ "$1" == "--prev" ]]; then
	{ mpc -q prev; get_cover; }
fi
