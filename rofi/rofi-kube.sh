#!/usr/bin/env bash

ALIAS_FILE="$HOME/.sybctl_gcloud_alias"

function rofi_menu() {
	rofi -width 25 -lines 5 -dmenu -i -p 'cluster: ' \
		-kb-row-tab '' \
		-kb-row-select Tab
}

clusters=$(cat "$ALIAS_FILE" | sed -n -e 's/alias \(.\+\)=.*/\1/p')
selected=$(echo "$clusters" | rofi_menu)
exit_code=$?

if [ $exit_code == 0 ]; then
  xdotool type --clearmodifiers "$selected"
fi
