#!/bin/bash

HOST=$(hostname)
CUSTOM_CONF=$HOME/.config/i3/scripts/setup-$HOST.sh

test -f $CUSTOM_CONF && sh $CUSTOM_CONF
