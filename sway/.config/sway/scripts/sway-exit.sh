#!/bin/sh
case "$1" in
    lock)
        lock
        ;;
    logout)
        swaymsg exit
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
