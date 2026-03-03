#!/usr/bin/env bash

i3flags='-n -t'

# Do fork if called from i3lock.service
if [[ "$1" == '-f' ]]; then
    i3flags=''
fi

if pgrep i3lock > /dev/null; then
    echo "An instance of i3lock is already running"
    exit 0
fi


icon="$HOME/dotfiles/scripts/assets/screenlocker/1.png"
tmpbg="$XDG_CACHE_HOME/i3lock-background.png"

if scrot "$tmpbg"; then
    convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
    convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
    i3flags="$i3flags -i $tmpbg"
fi

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1 &


i3lock $i3flags
