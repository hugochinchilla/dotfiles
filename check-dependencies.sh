#!/bin/bash

PROGRAMS="alacritty stow terminator xfce4-screenshooter xbindkeys xautolock scrot convert dbus-send i3lock i3status picom nitrogen networkmanager_dmenu zsh amixer xiccd colormgr clight xbacklight py3status"
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
