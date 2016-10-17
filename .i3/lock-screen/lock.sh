#!/usr/bin/env bash

icon="$HOME/.i3/lock-screen/1.png"
icon_alt="$HOME/.i3/lock-screen/2.png"

if [ -f "$icon_alt" ]; then
    if [ $((RANDOM%5)) -eq 1 ]; then
        icon=$icon_alt
    fi
fi

tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
i3lock -i "$tmpbg" -t -u
