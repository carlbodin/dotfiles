-- Hypridle Lua config file
-- https://wiki.hypr.land/Hypr-Ecosystem/hypridle/

hl.config({
    general = {
        lock_cmd = "pidof hyprlock || ~/.config/hypr/hyprlock.sh",
        before_sleep_cmd = "loginctl lock-session",
        after_sleep_cmd = "hyprctl dispatch dpms on",
    },

    listener = {
        {
            timeout = 180,
            on_timeout = "brightnessctl -s set 10",
            on_resume = "brightnessctl -r",
        },
        {
            timeout = 180,
            on_timeout = "brightnessctl -sd rgb:kbd_backlight set 0",
            on_resume = "brightnessctl -rd rgb:kbd_backlight",
        },
        {
            timeout = 600,
            on_timeout = "loginctl lock-session",
        },
        {
            timeout = 420,
            on_timeout = "hyprctl dispatch dpms off",
            on_resume = "hyprctl dispatch dpms on && brightnessctl -r",
        },
        {
            timeout = 1200,
            on_timeout = "systemctl suspend",
        },
    },
})
