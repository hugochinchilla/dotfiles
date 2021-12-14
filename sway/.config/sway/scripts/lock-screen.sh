#!/usr/bin/env bash

dir=$HOME/dotfiles/i3/.config/i3/screenlocker


if pgrep swaylock > /dev/null; then
    echo "An instance of swaylock is already running"
    exit 0
fi


icon="$dir/../screenlocker/1.png"
icon_alt="$dir/../screenlocker/2.png"

if [ -f "$icon_alt" ]; then
    if [ $((RANDOM%5)) -eq 1 ]; then
        icon=$icon_alt
    fi
fi

tmpbg="$XDG_CACHE_HOME/i3lock-background.png"

grimshot save screen "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1 &


swaylock -i "$tmpbg" -t

# Deactivate DPMS
#revert
