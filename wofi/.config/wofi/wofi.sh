#!/bin/bash

# Check if wofi is running
if pgrep -x "wofi" > /dev/null; then
    # Kill wofi if it's running
    pkill -x wofi
else
    # Launch wofi if it's not running
    wofi --show drun
fi