# Dotfiles

This repo contains stowable dotfiles, templates, and installation guides to share
between devices.

## Stow

The following configs are stowable with GNU `stow`.

```bash
- bash
- bash_desktop  # local desktop
- bash_rpi4  # local rpi4
- git
- hypridle
- hyprland
- hyprlock
- hyprpaper
- kitty
- pywal
- rofi-wayland
- starship
- swaync
- tmux
- wallpaper
- waybar
- wlogout
- wofi
```

### Installation

Install with pacman.

```bash
sudo pacman -S stow
```

Place the dotfiles repository in your user's home folder for stow to work, unless you
want to use custom paths for source and target directories.

```bash
cd && git clone git@github.com:carlbodin/dotfiles.git
```

### Usage

`cd` into the repo and then `stow` + `name of the config`. The `name of the config` must
be the name of a folder on the path, unless other is explicitly stated. E.g. `bash` in
the root of this project:

```bash
stow bash
```

`Stow` will now create a symlink of the dotfile config that points to the dotfile in the
repo. Subdirectories are created if needed.

To delete the symlink and `unstow` the dotfile, run the following. Subdirectories
created by `stow` in the stowing process will be deleted too, if empty.

```bash
stow -D bash
```

The folder structure in the repo is built in a way that enables smooth and modular
stowing. Each config is separate, and their folder structure tells `stow` how to create
subdirectories and place the symlink pointing to the repo config.

To work around this default behavior, and enable configs in other places of the file
system, use source and target directories when running `stow`.

```bash
stow -S -d /path/to/repo/dotfiles -t /path/where/to/place/symlink bash
```

### More behaviors

If the dotfile is already stowed, `stow` will do nothing.

If an original dotfile is at the target path, `stow` will yield a warning.

> WARNING! stowing bash would cause conflicts: \* cannot stow dotfiles/bash/.bashrc over
> existing target .bashrc since neither a link nor a directory and --adopt not specified
> All operations aborted.

In case `bash` is not on the path, `stow` will yield an error.

> stow: ERROR: The stow directory `/wrong/path` does not contain package bash

### Scripts

These scripts are available.

```bash
- backup-local-dotfiles.sh  # Save existing dotfiles to folder.
- stow-all.sh  # Stow "all" dotfiles.
- unstow-all.sh  # Remove stowed dotfiles.
```

The local bashrc versions, `penguin` and `rpi4`, are not included in `stow-all.sh`.

## Templates

Templates on how to write configuration files.

```bash
- fstab  # The `/etc/fstab` config.
- sddm  # Simple Desktop Display Manager config, and theme paths.
- ssh  # The `config` and `authorized_keys` files.
- vscode  # User settings, extensions, and extension configs.
```

## Arch Hyprland Setup

In `arch_hyprland_setup.md`, there are notes on how I setup `hyprland` on arch linux.

## Add Default Apps

If you want to establish default apps for specific file types, you can either use
`Nautilus GUI` or `xdg-mime` in the terminal.

### Nautilus GUI

1. Right click on file.
2. Choose `Open With...`
3. Select your app, turn on the toggle `Always use for this file type`, and then `Open`.

### xdg-mime

Say you want to add `swayimg` as default for the JPEG file type.

```bash
xdg-mime default swayimg.desktop image/jpg
```

What happens is that an entry is added to the `~/.config/mimeapps.list`.

```bash
...
[Default Applications]
image/jpeg=swayimg.desktop
image/png=swayimg.desktop
image/gif=swayimg.desktop
...
```
