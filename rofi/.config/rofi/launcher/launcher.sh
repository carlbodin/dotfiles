#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

# Kill rofi if it's running.
if pgrep -x "rofi" > /dev/null; then
    pkill -x rofi
    exit 0
fi

# Set theme.
dir="$HOME/.config/rofi/launcher"
theme='type-2-style-1'

rofi -show drun -theme ${dir}/${theme}.rasi -config ${dir}/config.rasi -normalize-match
