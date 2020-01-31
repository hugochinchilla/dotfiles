#!/bin/bash

DISPLAYS=`xrandr -q | grep " connected" | awk {'print $1'}`

if [[ -f current_brightness ]]
then
   BRIGHTNESS=`cat current_brightness`
else
   BRIGHTNESS=1
   echo 1 > current_brightness
fi

for VALUE in .6 .65 .7 .75 .8 .85 .9 .95 1 .6
do
    if [[ "x$STOP" == "x1" ]]
    then
        BRIGHTNESS="$VALUE"
        break
    fi

    if [[ "x$VALUE" == "x$BRIGHTNESS" ]]
    then
        STOP=1
        continue
    else
        STOP=0
    fi
done


echo $BRIGHTNESS > current_brightness
for OUTPUT in $DISPLAYS
do
    xrandr --output $OUTPUT --brightness $BRIGHTNESS
done
notify-send -u low -t 400 "Brightness set to $BRIGHTNESS"
