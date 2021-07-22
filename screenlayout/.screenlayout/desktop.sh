#!/bin/sh
xrandr --output DisplayPort-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DisplayPort-0 --off --output DVI-D-0 --off --output HDMI-A-1 --mode 2560x1440 --pos 2560x0 --rotate normal --output HDMI-A-0 --off
xcalib -d :0 -o 0 .local/share/icc/U2721DE\ \#1\ 2021-07-22\ 15-21\ 2.2\ F-S\ XYZLUT+MTX.icc
xcalib -d :0 -o 1 .local/share/icc/U2719D\ \#2\ 2021-07-22\ 15-47\ 2.2\ F-S\ XYZLUT+MTX.icc
