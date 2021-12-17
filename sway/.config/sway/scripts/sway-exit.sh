#!/bin/sh
lock() {
    ~/.config/sway/scripts/lock-screen.sh
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        swaymsg exit
        ;;
    suspend)
        lock && systemctl suspend-then-hibernate
        ;;
    hibernate)
        lock && systemctl hibernate
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
