#!/bin/bash

# Toggle process.
if pgrep -x "waybar" > /dev/null; then
    pkill -x "waybar"
else
    waybar -s ~/.config/waybar/style.css &
fi


