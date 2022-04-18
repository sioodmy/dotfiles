#!/bin/bash

screenshot=/tmp/screenshot.png
sspath=~/pics/ss

window () {
    eww close screenshottool
    maim -st 9999999 | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage $screenshot
}

area () {
    eww close screenshottool
    maim -s $screenshot
}

wscreen () {
    eww close screenshottool
    sleep 0.6;
    maim $screenshot
}

ewwss () {
    eww update screenshotpath=$screenshot
    eww open screenshot
}

discard () {
    eww close screenshot;
    rm "${screenshot}"
}

upload () {
    eww close screenshot;
    url="$(curl -F"file=@$screenshot" https://0x0.st)" 
    echo $url | xclip -selection clipboard 
    notify-send "Link copied to clipboard" "${url}" -i $screenshot
}

save () {
    eww close screenshot;
    newname="screenshot-$(date +%H-%M-%S_%d-%m-%y).png"
    mkdir -p $sspath
    cp $screenshot $sspath/$newname
    notify-send "Screenshot saved!" "$sspath/$newname" -i $screenshot
}

copy () {
    eww close screenshot;
    xclip -selection clipboard -t image/png -i $screenshot
    notify-send "Screenshot copied" -i $screenshot
}

menu () {
    eww close screenshottool || \
    eww windows | rg -q "\*screenshot" || \
        eww open screenshottool 
}

case $1 in
    "screen") wscreen && ewwss ;;
    "window") window && ewwss ;;
    "area") area && ewwss ;;
    "discard") discard ;;
    "copy") copy ;;
    "upload") upload ;;
    "save") save ;;
    "menu") menu ;;
    *) echo Invalid option;;
esac
