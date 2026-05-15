-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@100",
    position = "0x0",
    scale    = 1,
    cm       = "auto",
    vrr      = 3,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "3440x360",
    scale    = 1,
})

-- Laptop x360.
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
    cm       = "auto",
})

-- Default workspaces for monitors
hl.workspace({ workspace = 1, monitor = "DP-1" })

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nautilus -w"
local menu        = os.getenv("HOME") .. "/.config/wofi/wofi.sh"
local browser     = "firefox"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper &")
    hl.exec_cmd("hypridle &")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("swaync &")
    hl.exec_cmd("wl-paste --type text --watch cliphist -max-items 15 store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist -max-items 15 store &")
    hl.exec_cmd("hyprctl dispatch workspace 1")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart.
--
-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })
--
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 9,

        border_size = 0,

        col = {
            active_border   = { colors = {"rgba(11aa11ee)", "rgba(114411ee)"}, angle = 45 },
            inactive_border = "rgba(55555588)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 18,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 2,
            passes    = 4,
            new_optimizations = true,
            vibrancy  = 0.1696,
            brightness = 1.5,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "slide" })

hl.config({
  dwindle = {
      force_split                  = 0,
      preserve_split               = false,
      smart_split                  = false,
      smart_resizing               = true,
      permanent_direction_override = false,
      special_scale_factor         = 1,
      split_width_multiplier       = 1.0,
      use_active_for_splits        = true,
      default_split_ratio          = 1.0,
      split_bias                   = 0,
      precise_mouse_move           = false,
  },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "se",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity = -0.9,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name        = "name",
    sensitivity = 0.0,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/hyprlock.sh"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/wlogout/wlogout.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/select_wallpaper.sh"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/waybar_toggle.sh"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/cliphist_menu.sh"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/cliphist_menu.sh --delete"))
hl.bind(mainMod .. " + SHIFT + ALT + C", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/cliphist_menu.sh --wipe"))

hl.bind("PRINT", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/hyprshot.sh --freeze -m region"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/hyprshot.sh -m window"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/hyprshot.sh -m output -m active"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + plus",       hl.dsp.exec_cmd("hyprctl dispatch resizeactive 40 0"))
hl.bind(mainMod .. " + minus",      hl.dsp.exec_cmd("hyprctl dispatch resizeactive -40 0"))
hl.bind(mainMod .. " + SHIFT + plus",  hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 40"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -40"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),               { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),              { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("XF86Display",    hl.dsp.exec_cmd("hyprctl dispatch dpms toggle"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    name  = "windowrule-1",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "windowrule-2",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "windowrule-3",
    idle_inhibit = "fullscreen",
    match = { class = "^(*)$" },
})

hl.window_rule({
    name = "windowrule-4",
    idle_inhibit = "fullscreen",
    match = { title = "^(*)$" },
})

hl.window_rule({
    name = "windowrule-5",
    idle_inhibit = "fullscreen",
    match = { fullscreen = true },
})

hl.window_rule({
    name = "windowrule-6",
    opacity = 1.00,
    match = { class = "^(Spotify)$" },
})

hl.window_rule({
    name = "windowrule-7",
    opacity = 1.00,
    match = { class = "^(discord)$" },
})

hl.window_rule({
    name = "windowrule-8",
    opacity = 1.00,
    match = { class = "^(firefox)$" },
})

hl.window_rule({
    name = "windowrule-9",
    opacity = 1.00,
    match = {
        class = "^(firefox)$",
        title = "^(.*(YouTube|Twitch).*)$",
    },
})

hl.window_rule({
    name = "windowrule-10",
    opacity = 1.00,
    match = { class = "^(localsend)$" },
})

hl.window_rule({
    name = "windowrule-11",
    opacity = 1.00,
    match = { class = "^(Code)$" },
})

hl.window_rule({
    name = "windowrule-12",
    opacity = 1.00,
    match = { class = "^(org.gnome.Nautilus)$" },
})

hl.window_rule({
    name = "windowrule-13",
    opacity = 1.00,
    match = { class = "^(org.gnome.baobab)$" },
})

hl.window_rule({
    name = "windowrule-14",
    opacity = 1.00,
    match = { class = "^(blueman-manager)$" },
})

hl.layer_rule({
    name = "layerrule-1",
    animation = "popin 50%",
    match = { namespace = "kitty" },
})

hl.layer_rule({
    name = "layerrule-2",
    blur = true,
    ignore_alpha = 0.2,
    animation = "popin 50%",
    match = { namespace = "wofi" },
})

hl.layer_rule({
    name = "layerrule-3",
    blur = true,
    ignore_alpha = 0.5,
    match = { namespace = "waybar" },
})

hl.layer_rule({
    name = "layerrule-4",
    blur = true,
    match = { namespace = "logout_dialog" },
})

hl.layer_rule({
    name = "layerrule-5",
    ignore_alpha = 0.1,
    animation = "popin 100%",
    match = { namespace = "logout_dialog" },
})

hl.layer_rule({
    name = "layerrule-6",
    blur = true,
    ignore_alpha = 0.2,
    animation = "popin 85%",
    match = { namespace = "swaync-control-center" },
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
