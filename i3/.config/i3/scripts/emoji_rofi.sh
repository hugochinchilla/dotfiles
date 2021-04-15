#!/bin/bash

DB_FILE="$HOME/.frece_emoji.db"

item=$(frece print "$DB_FILE" | rofi "$@" -dmenu -font 'Noto Sans 22' -columns 2)
[[ -z $item ]] && exit 1
frece increment "$DB_FILE" "$item"

emoji=$(cut -d$'\t' -f1 <<<"$item" | sed -e 's/[[:space:]]*$//')
echo -n "$emoji" | xclip -selection clipboard
