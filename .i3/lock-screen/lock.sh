#!/usr/bin/env bash

revert() {
	xset dpms 0 0 0
}
trap revert SIGHUP SIGINT SIGTERM


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

# Pause Spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
# Enable DPMS to stop displays on inactivity
# xset +dpms dpms (standby time) (suspend time) (off time)
xset +dpms dpms 0 60 60
# Lock the screen
i3lock -i "$tmpbg" -t -u -n
# Deactivate DPMS
revert
