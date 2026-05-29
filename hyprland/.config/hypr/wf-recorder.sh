#!/bin/bash

# Check if wf-recorder is running.
if pgrep -x "wf-recorder" > /dev/null; then
    # If yes, kill gracefully.
    pkill  -INT -x wf-recorder && notify-send "Screen recording stopped."
else
    # If not, start recording.
    mkdir -p "$HOME/Videos/screencasts"
    wf-recorder -g "$(slurp)" -f "$HOME/Videos/screencasts/wf-recorder-$(date +%Y%m%d-%H%M%S).mkv"
    notify-send "Screen recording started." "Use the same bind to stop."
fi

