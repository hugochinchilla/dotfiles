#!/bin/sh

PROGRAMS="stow terminator xfce4-screenshooter xbindkeys xautolock scrot convert dbus-send i3lock compton nitrogen zsh amixer"

ERROR="✘"
SUCCESS="✔"

. ./colors.sh

for program in $PROGRAMS; do
    if [ $(which $program) ]; then
        echo "${txtgrn}${SUCCESS}${txtrst} $program"
    else
        echo "${txtred}${ERROR}${txtrst} $program"
    fi
done;
