# Games on Arch

- Steam
- EpicGames
- Gamescope
- Emulation

## Steam

```bash
sudo pacman -S steam
```

### multilib

To enable this, edit the `/etc/pacman.conf` by uncommenting the `[multilib]` section,
and then run `pacman -Sy` to sync your new repositories.

## EpicGames and Herioc Games Launcher

Access your EpicGames library and launcher through the app Herioc Games Launcher
available at AUR.

```bash
yay -S heroic-games-launcher-bin
```

If the game does not launch properly, check community compatibility discussions and
solutions on [ProtonDB](https://www.protondb.com).

Try a different Proton version in `Wine Manager` in the left-most menu.

If the game launches in wrong resolution, struggles with fullscreen, grabbing the
cursor, etc, then try `gamescope`. See guide below.

## Gamescope

Not all desktop environments or window managers are optimized for gaming. Gamescope is a
microcompositor to solve this problem. It creates an isolated graphical environment that
has its own rendering pipeline, regardless of any other compositors in an OS. Gamescope
bring compatibility, ease of configuration, and sometimes added graphical functionality.

```bash
sudo pacman -S gamescope
```

### Use in Heroic Games Launcher

Add as Heroic Games Launcher wrapper script in a game specific advanced settings. Scroll
to the **Wrapper command:** section and type `gamescope` in the **Wrapper / New
Wrapper** column, and add gamescope arguments in the **Arguments / Wrapper Arguments**.

Example usage in Heroic with dummy arguments.

```bash
# NAME     |  # ARGS
gamescope  |  -w 3440 -h 1440 --force-grab-cursor -f --
```

### Use in Steam

Example usage in Steam with dummy arguments.

```bash
gamescope -w 2560 -h 1080 -W 3440 -H 1440 -F nis -O DP-1 -f -- %command%
```

### Use in Terminal

Example usage in terminal with dummy arguments.

```bash
gamescope -w 1920 -h 1080 -b --mangoapp --adaptive-sync -- </path/to/game/binary>
```

Some use this to wrap the entire Heroic Games Launcher app, but it is not flexible and
therefore not recommended.

```bash
gamescope -w 1920 -h 1080 -b --mangoapp --adaptive-sync -- heroic
```

### Common Arguments

See `gamescope --help` in terminal for more.

```bash
-h 1080                 # Rendered height.
-w 1920                 # Rendered width.
-H 1440                 # Output height. Use for scaling.
-W 2560                 # Output width.

-S, --scaler            # Upscaler type (auto, integer, fit, fill, stretch)
-F, --filter            # Upscaler filter (linear, nearest, fsr, nis, pixel)
                        #   fsr => AMD FidelityFX™ Super Resolution 1.0
                        #   nis => NVIDIA Image Scaling v1.0.3
--sharpness             # Upscaler sharpness from 0 (max) to 20 (min).

-s, --mouse-sensitivity # Multiply mouse movement by given decimal number.
-r 100                  # Game refresh rate.
--framerate-limit 200   # Set a simple framerate limit.
--mangoapp              # Launch with the mangoapp.
--adaptive-sync         # Enable adaptive sync if available (VRR).

-f                      # Make the window fullscreen.
-b, --borderless        # Make the window borderless.

-g, --grab              # Grab keyboard.
--force-grab-cursor     # Grab mouse cursor.
-O, --prefer-output     # List monitor prio: DP-1, HDMI-A-1
```

## Emulation

    N64 -> Simple64
    Gamecube & Wii -> Dolphin
    WiiU -> Cemu

### Simple64

See guide [n64_emulation.md](n64_emulation.md).

### Dolphin

See guide [gamecube_wii_emulation.md](gamecube_wii_emulation.md).

### Cemu

See guide [wiiu_emulation.md](wiiu_emulation.md) for Cemu install, setup, and usage.
Also covers downloading games through `WiiUDownloader`.
