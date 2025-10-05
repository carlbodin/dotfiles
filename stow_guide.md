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
- rofi
- rofi-powermenu
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
