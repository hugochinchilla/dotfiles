#!/usr/bin/env bash

dir=$(dirname ${BASH_SOURCE})

i3flags='-n '

# Do fork if called from i3lock.service
if [[ "$1" == '-f' ]]; then
    i3flags=''
fi

if pgrep i3lock > /dev/null; then
    echo "An instance of i3lock is already running"
    exit 0
fi

revert() {
	xset dpms 0 0 0
}
trap revert SIGHUP SIGINT SIGTERM


icon="$dir/../screenlocker/1.png"
icon_alt="$dir/../screenlocker/2.png"

if [ -f "$icon_alt" ]; then
    if [ $((RANDOM%5)) -eq 1 ]; then
        icon=$icon_alt
    fi
fi

tmpbg="$XDG_CACHE_HOME/i3lock-background.png"

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1 &
# Enable DPMS to stop displays on inactivity
# xset +dpms dpms (standby time) (suspend time) (off time)
xset +dpms dpms 0 60 60


i3lock -i "$tmpbg" -t -u $i3flags

# Deactivate DPMS
revert
