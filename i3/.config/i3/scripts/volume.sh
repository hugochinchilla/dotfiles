#!/bin/bash

VOLUME=`amixer get Master | egrep -o '[0-9]+%'`
MUTED=`amixer get Master | grep -o '\[off\]'`

if [ "$MUTED" == "[off]" ]; then
    VOLUME=" Muted"
else
    VOLUME=" $VOLUME"
fi

echo $VOLUME
