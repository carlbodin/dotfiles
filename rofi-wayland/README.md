# Rofi-Wayland

## Install

This is the wayland port with limited functionality of the original version for X11
display server.

> **NOTE** These configs do not seem to work for the original program. This seems to be
> connected to the `configuration` config block.

```bash
sudo pacman -S rofi-wayland
```

## Config

Config guide: `https://man.archlinux.org/man/rofi.1.en`.

Create a configuration file from current setup: `rofi -dump-config > ~/config.rasi`.

## Themes

Extensive rofi theme library on Github: `https://github.com/adi1090x/rofi`.

Place themes files into folder: `$HOME/.local/share/rofi/themes/`.

Load a theme using in the currently used config: `@theme "/path/to/config.rasi"`. Or
point to the config using a flag when launching `rofi`. Default config is
`$HOME/.config/rofi/config.rasi`.
