#!/bin/sh

sh $HOME/.screenlayout/desktop.sh

# Load screen calibration profiles
xcalib -d :0 -o 0 .local/share/icc/U2721DE\ \#1\ 2021-07-22\ 15-21\ 2.2\ F-S\ XYZLUT+MTX.icc
xcalib -d :0 -o 1 .local/share/icc/U2719D\ \#2\ 2021-07-22\ 15-47\ 2.2\ F-S\ XYZLUT+MTX.icc

# kill nitrogen, which takes some time to restore the wallpaper and might be still running
pkill -9 nitrogen
# enable time changing wallpaper
dwall -s catalina -k &

# restart picom because it corrupts screen when resolution changes
pkill -9 picom && pwait picom
picom -b --config ~/.config/picom.conf
