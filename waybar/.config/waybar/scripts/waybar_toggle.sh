#!/bin/bash

# Toggle process.
if pgrep -x "waybar" > /dev/null; then
    pkill -x "waybar"
else
    # Check if pywal colors exist.
    if [ -f "$HOME/.cache/wal/colors-waybar.css" ]; then 
        waybar -s ~/.config/waybar/style_wal.css &
    else
        waybar -s ~/.config/waybar/style.css &
    fi
fi


