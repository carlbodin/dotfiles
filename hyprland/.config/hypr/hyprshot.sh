#!/bin/bash

# Toggle if running.
if pgrep -x "hyprshot" > /dev/null; then
    pkill -x hyprshot
    exit 0
fi

# Pass all arguments to hyprshot.
hyprshot "$@"