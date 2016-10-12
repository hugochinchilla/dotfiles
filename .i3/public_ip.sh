#!/bin/bash

IP=`curl -s canihazip.com/s`

if [ -L /sys/class/net/tun0 ]; then
    VPN="Habitissimo"
else
    VPN=""
fi

if [ -z "$IP" ]; then
    IP="not connected"
fi

if [ -n "$VPN" ]; then
    IP="VPN: $VPN - $IP"
fi

echo $IP

