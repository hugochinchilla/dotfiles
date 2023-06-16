#!/bin/bash

HOST=$(hostname)
CUSTOM_CONF=$HOME/dotfiles/scripts/setup-host-$HOST.sh

test -f $CUSTOM_CONF && sh $CUSTOM_CONF
