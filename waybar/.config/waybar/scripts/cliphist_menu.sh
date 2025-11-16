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
        cliphist list | wofi --dmenu --columns 1 --lines 8 --width 600 --allow-images -i --prompt "Delete entry" | cliphist delete
        exit 0
        ;;
esac

# Normal clipboard selection.
cliphist list | wofi --dmenu --columns 1 --lines 8 --width 600 --allow-images -i --prompt "Select item to copy" | cliphist decode | wl-copy
