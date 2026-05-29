#!/bin/bash

# Check if wf-recorder is running.
if pgrep -x "wf-recorder" > /dev/null; then
    # If yes, kill gracefully.
    pkill  -INT -x wf-recorder && notify-send "wf-recorder" "Screen recording stopped."
else
    # If not, start recording.
    if [[ "$1" == "--output" ]]; then
        mkdir -p "$HOME/Videos/screencasts"
        notify-send "wf-recorder" "Fullscreen recording started, use the same bind to stop."
        wf-recorder -o DP-1 -f "$HOME/Videos/screencasts/wf-recorder-$(date +%Y%m%d-%H%M%S).mkv"
    else
        GEOMETRY=$(slurp)
        mkdir -p "$HOME/Videos/screencasts"
        notify-send "wf-recorder" "Selected area recording started, use the same bind to stop."
        wf-recorder -g "$GEOMETRY" -f "$HOME/Videos/screencasts/wf-recorder-$(date +%Y%m%d-%H%M%S).mkv"
    fi
fi
