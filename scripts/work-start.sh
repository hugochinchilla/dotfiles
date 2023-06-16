#!/bin/bash

i3-msg 'workspace 1; exec --no-startup-id /usr/bin/gtk-launch jetbrains-webstorm.desktop'
i3-msg 'workspace 2; exec --no-startup-id /usr/bin/alacritty'
i3-msg 'workspace 3; exec --no-startup-id /usr/bin/google-chrome-stable --profile-directory="Profile 2"'
i3-msg 'workspace 4; exec --no-startup-id /usr/bin/slack'
