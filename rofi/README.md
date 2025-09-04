# Rofi

**NOTE** - Different versions of `Rofi` support different configuration syntax.

## Install

Install `Rofi` on X11 display server.

```bash
sudo pacman -S rofi
```

There is also a wayland display server port with limited functionality. But then,
consider using `Wofi` instead.

```bash
sudo pacman -S rofi-wayland
```

## Usage

Run in terminal.

```bash
rofi -show drun
```

Tip, run it from a keyboard shortcut to quickly access your app launcher. Point the
shortcut to the `launcher.sh` script, which points to the config and theming.

Edit the script to switch themes. Edit the `config.rasi` or `theme.rasi` files for
tweaking the functionality or visuals of the program.

## Config

Default config file is located at `$HOME/.config/rofi/config.rasi`. This is loaded if it
exists, and will be overwritten by explicitly declared config arguments.

```bash
rofi -show drun -config /path/to/config -theme /path/to/theme
```

Config guide on the Arch [manual pages](https://man.archlinux.org/man/rofi.1.en).
Extensive `Rofi` multipurpose theming library on Github by user
[adi1090x](https://github.com/adi1090x/rofi). Configs and theming for app launcher,
power menus, and applets.

Useful command. Create a configuration file from current setup.

```bash
rofi -dump-config > ~/config.rasi
```
