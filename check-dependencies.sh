#!/bin/bash

PROGRAMS="alacritty stow terminator xfce4-screenshooter xbindkeys xautolock scrot convert dbus-send i3lock compton nitrogen zsh amixer xiccd colormgr"

ERROR="✘"
SUCCESS="✔"

. ./colors.sh

for program in $PROGRAMS; do
    if which $program &> /dev/null; then
        echo -e "${txtgrn}${SUCCESS}${txtrst} $program"
    else
        echo -e "${txtred}${ERROR}${txtrst} $program"
    fi
done;
