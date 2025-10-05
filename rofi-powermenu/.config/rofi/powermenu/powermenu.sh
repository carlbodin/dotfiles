#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
## style-6   style-7   style-8   style-9   style-10

# Kill rofi if it's running.
if pgrep -x "rofi" > /dev/null; then
    pkill -x rofi
    exit 0
fi

# Set theme.
dir="$HOME/.config/rofi/powermenu"
theme='style-2'

# Buttons.
shutdown='󰐥'    # nf-md-power
reboot='󰜉'      # nf-md-restart
lock='󰌾'       # nf-md-lock
suspend='󰤄'     # nf-md-power_sleep
logout='󰍃'      # nf-md-logout

rofi_cmd() {
	rofi -dmenu \
		-config ${dir}/config.rasi \
		-theme ${dir}/${theme}.rasi
}


# Pass button variables to rofi dmenu.
run_rofi() {
	echo -e "$suspend\n$shutdown\n$reboot\n$logout" | rofi_cmd
}

# Map button to command.
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		loginctl lock-session
        ;;
    $suspend)
		mpc -q pause
		amixer set Master mute
		systemctl suspend
        ;;
    $logout)
		gnome-session-quit --logout --no-prompt
        ;;
esac