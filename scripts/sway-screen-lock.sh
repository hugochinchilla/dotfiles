#!/usr/bin/env bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export WAYLAND_DISPLAY=wayland-1
export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$(id -u).$(pgrep -x sway).sock

LOCK_ICON=$HOME/dotfiles/scripts/assets/screenlocker/1.png

# -e flag is added as workaround
# https://github.com/swaywm/swaylock/issues/124#issuecomment-572369286
SWAYLOCK_FLAGS="--daemonize -e -c 2E3436"


if pgrep swaylock > /dev/null; then
    echo "An instance of swaylock is already running"
    exit 0
fi



tmpbg="${XDG_CACHE_HOME:-${HOME}/.cache}/i3lock-background.png"

if grimshot save screen $tmpbg > /dev/null; then
    convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
    convert "$tmpbg" "$LOCK_ICON" -gravity center -composite -matte "$tmpbg"
    SWAYLOCK_FLAGS="${SWAYLOCK_FLAGS} -i $tmpbg"
fi

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1 &


swaylock $SWAYLOCK_FLAGS

