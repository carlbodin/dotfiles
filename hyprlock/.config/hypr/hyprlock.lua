-- Hyprlock Lua config file
-- https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/

hl.config({
    source = os.getenv("HOME") .. "/.cache/wal/colors-hyprland.conf",

    general = {
        hide_cursor = true,
        ignore_empty_input = true,
    },

    background = {
        monitor = "",
        path = os.getenv("HOME") .. "/.config/hypr/select_wallpaper.jpg",
        blur_passes = 4,
        blur_size = 3,
    },

    label = {
        {
            monitor = "",
            text = 'cmd[update:1000] echo "<b><big> $(date +"%H:%M") </big></b>"',
            color = "rgba(255, 255, 255, 0.6)",
            font_size = 72,
            font_family = "Noto Sans",
            position = "0, 120",
            halign = "center",
            valign = "center",
        },
        {
            monitor = "",
            text = 'cmd[update:43200000] date +"%A %d %B"',
            color = "rgba(255, 255, 255, 0.4)",
            font_size = 30,
            font_family = "Noto Sans",
            position = "0, 50",
            halign = "center",
            valign = "center",
        },
    },

    input_field = {
        monitor = "",
        size = "200, 50",
        outline_thickness = 0,
        dots_size = 0.25,
        dots_spacing = 0.3,
        dots_center = true,
        dots_rounding = -1,
        inner_color = "rgba(0, 0, 0, 0.2)",
        font_color = "rgba(255, 255, 255, 0.4)",
        fail_color = "rgba(255, 80, 80, 0.4)",
        fade_on_empty = true,
        fade_timeout = 200,
        placeholder_text = "",
        fail_text = "Wrong password <b>($ATTEMPTS)</b>",
        hide_input = false,
        rounding = -1,
        position = "0, -70",
        halign = "center",
        valign = "center",
    },
})
