#!/bin/bash

# Check if wf-recorder is running.
if pgrep -x "wf-recorder" > /dev/null; then
    # If yes, kill gracefully.
    pkill  -INT -x wf-recorder && notify-send "wf-recorder" "Screen recording stopped."
else
    # If not, start recording.
    GEOMETRY=$(slurp)
    mkdir -p "$HOME/Videos/screencasts"
    notify-send "wf-recorder" "Screen recording started, use the same bind to stop."
    wf-recorder -g "$GEOMETRY" -f "$HOME/Videos/screencasts/wf-recorder-$(date +%Y%m%d-%H%M%S).mkv"
fi

