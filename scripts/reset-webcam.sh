#!/bin/bash

WEBCAM_USB_BUS=$(lsusb  | grep Webcam | awk -F'[^0-9]*' {'print "/dev/bus/usb/" $2 "/" $3'})

POLKIT_AGENT_PID=$(pidof polkit-gnome-authentication-agent-1)

if [ -z "$POLKIT_AGENT_PID" ]; then
    # start temporary agent
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
    sleep 1
fi

pkexec /usr/bin/usbreset $WEBCAM_USB_BUS

if [ -z "$POLKIT_AGENT_PID" ]; then
    # kill temporary agent
    kill $!
fi
