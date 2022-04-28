#!/bin/bash

sleep 0.2

xdotool search --name '^Meet - .+$' windowactivate
if [ "$?" = "0" ]; then
	exit
fi

WIN_INSTANCES=$(xdotool search --name 'Google Chrome')

for WINID in $WIN_INSTANCES
do
	WINID_HEX=$(printf "0x%x" $WINID)
	xdotool windowactivate $WINID
	INITIAL_TAB=$(xdotool getactivewindow getwindowname)
    while [ "$CURRENT_TAB" != "$INITIAL_TAB" ]; do
		xwininfo -id $WINID_HEX | grep -q Meet
		if [ "$?" -ne 0 ]; then
			xdotool key --window $WINID ctrl+Tab
			CURRENT_TAB=$(xdotool getactivewindow getwindowname)
		else
			xdotool search --name '^Meet - .+$' windowactivate
			exit 0
		fi
		#sleep 0.1
	done
done
