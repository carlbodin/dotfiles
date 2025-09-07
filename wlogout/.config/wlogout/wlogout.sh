#!/bin/sh

RESOLUTION=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | "\(.width)x\(.height)"')
if [ "$RESOLUTION" = "3440x1440" ]; then
    CSS_FILE=~/.config/wlogout/style_3440x1440.css
elif [ "$RESOLUTION" = "3840x2160" ] || [ "$RESOLUTION" = "4096x2160" ]; then
    CSS_FILE=~/.config/wlogout/style_3840x2160.css
else    
    CSS_FILE=~/.config/wlogout/style_1920x1080.css
fi

wlogout --buttons-per-row 2 --css "$CSS_FILE"
