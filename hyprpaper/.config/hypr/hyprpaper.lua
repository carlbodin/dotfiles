-- Hyprpaper Lua config file
-- https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/

hl.config({
    wallpaper = {
        -- Laptop x360
        -- {
        --     monitor = "eDP-1",
        --     path = os.getenv("HOME") .. "/.config/hypr/select_wallpaper.jpg",
        --     fit_mode = "cover",
        -- },
        {
            monitor = "DP-1",
            path = os.getenv("HOME") .. "/.config/hypr/select_wallpaper.jpg",
            fit_mode = "cover",
        },
        {
            monitor = "HDMI-A-1",
            path = os.getenv("HOME") .. "/.config/hypr/select_wallpaper.jpg",
            fit_mode = "cover",
        },
    },

    splash = false,
    splash_offset = 20,
    ipc = false,
})
