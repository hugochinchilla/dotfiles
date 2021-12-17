#!/usr/bin/env bash

dir=$HOME/dotfiles/i3/.config/i3/screenlocker
SWAYLOCK_FLAGS="--daemonize"


if pgrep swaylock > /dev/null; then
    echo "An instance of swaylock is already running"
    exit 0
fi


LOCK_ICON=$(ls $dir/../screenlocker/*.png | shuf -n 1)

tmpbg="${XDG_CACHE_HOME:-${HOME}/.cache}/i3lock-background.png"

if grimshot save screen $tmpbg > /dev/null; then
    convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
    convert "$tmpbg" "$LOCK_ICON" -gravity center -composite -matte "$tmpbg"
    SWAYLOCK_FLAGS="${SWAYLOCK_FLAGS} -i $tmpbg"
fi

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1 &


swaylock $SWAYLOCK_FLAGS

