#!/bin/sh

case $XDG_SESSION_TYPE in
  x11)
    MSG_BIN=i3-msg
    SCREEN_LOCKER=~/dotfiles/scripts/i3-screen-lock.sh
    ;;

  wayland)
    MSG_BIN=swaymsg
    SCREEN_LOCKER=~/dotfiles/scripts/sway-screen-lock.sh
    ;;

  *)
    exit 1
    ;;
esac

case "$1" in
    lock)
        $SCREEN_LOCKER
        ;;
    logout)
        $MSG_BIN exit
        ;;
    suspend)
        systemctl suspend-then-hibernate
        ;;
    hibernate)
        systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff -i
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
