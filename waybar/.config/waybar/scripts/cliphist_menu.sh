#!/bin/bash

# Parse flags.
case "$1" in
    --wipe)
        pkill -f "wl-paste.*cliphist"
        rm -f ~/.cache/cliphist/db
        wl-paste --type text --watch cliphist -max-items 15 store &
        wl-paste --type image --watch cliphist -max-items 15 store &
        cliphist wipe
        exit 0
        ;;
    --delete)
        selected=$(cliphist list | awk -F'\t' '{$1=""; print substr($0,2)}' | wofi --dmenu --columns 1 --lines 8 --width 600 --allow-images -i --prompt "Delete entry")
        if [ -n "$selected" ]; then
            cliphist list | grep -F "$selected" | head -n1 | cliphist delete
        fi
        # cliphist list | wofi --dmenu --columns 1 --lines 8 --width 600 --allow-images -i --prompt "Delete entry" | cliphist delete
        exit 0
        ;;
esac

# Normal clipboard selection.
selected=$(cliphist list | awk -F'\t' '{$1=""; print substr($0,2)}' | wofi --dmenu --columns 1 --lines 8 --width 600 --allow-images -i --prompt "Select item to copy")
if [ -n "$selected" ]; then
    cliphist list | grep -F "$selected" | head -n1 | cliphist decode | wl-copy
fi