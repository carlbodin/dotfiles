#!/bin/bash

# Check if wofi is running.
if pgrep -x "wofi" > /dev/null; then
    # Kill wofi if it's running.
    pkill -x wofi
else

    WOFI_ARGS="--dmenu --width 770 --allow-images --insensitive"

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
            cliphist list | wofi $WOFI_ARGS --prompt "Delete entry" | cliphist delete
            exit 0
            ;;
    esac

    # Normal clipboard selection.
    cliphist list | wofi $WOFI_ARGS --prompt "Select item to copy" | cliphist decode | wl-copy
fi