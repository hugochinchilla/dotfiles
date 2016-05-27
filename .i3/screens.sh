#/bin/bash

xrandr --output DP1 --off --output eDP1 --auto

i3-nagbar -m "SUPER-COOL I3WM SCREEN CONFIG UTILITY" -t warning -f 'pango:DejaVu Sans Mono 22' \
	-b "Integrated Only"             "xrandr --output eDP1 --auto --output DP1 --off" \
	-b "Integrated + External Left"  "xrandr --output eDP1 --auto --output DP1 --auto --left-of eDP1" \
	-b "Integrated + External Right" "xrandr --output eDP1 --auto --output DP1 --auto --right-of eDP1" \
	-b "Mirror"                      "xrandr --output eDP1 --auto --output DP1 --auto"
