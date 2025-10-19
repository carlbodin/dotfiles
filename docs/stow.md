# Stow

The following configs are stowable with GNU `stow`.

```bash
- bash
- bash-desktop  # local desktop
- bash-rpi4  # local rpi4
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

## Scripts

I have two utility scripts for stowing, `backup-local-dotfiles.sh` and `stow-all.sh`.

#### Backup Local Dotfiles

The backup process is moving, not copying, the relevant files to
`~/dotfiles/local-dotfiles-backup/`. This enables you to run the script `stow-all.sh`
directly after.

```bash
./backup-local-dotfiles.sh [--dry-run] [--restore]
```

Run with the `--restore` flag to copy the backed-up files back to their original path.
This mode also unstows the relevant dotfile before copying the original back to its
path.

#### Stow All

Iterates over all repository folders, unless mentioned in `.stow-global-ignore`, and
runs `stow` on them. The result is reported in the terminal. Use the `--unstow` flag to
reverse the process and remove all symlinks.

```bash
./stow-all.sh [--unstow]
```

## Installation

Install with pacman.

```bash
sudo pacman -S stow
```

Place the dotfiles repository in your user's home folder for stow to work, unless you
want to use custom paths for source and target directories.

```bash
cd && git clone git@github.com:carlbodin/dotfiles.git
```

## Usage

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

## More behaviors

If the dotfile is already stowed, `stow` will do nothing.

If an original dotfile is at the target path, `stow` will yield a warning.

> WARNING! stowing bash would cause conflicts: \* cannot stow dotfiles/bash/.bashrc over
> existing target .bashrc since neither a link nor a directory and --adopt not specified
> All operations aborted.

In case `bash` is not on the path, `stow` will yield an error.

> stow: ERROR: The stow directory `/wrong/path` does not contain package bash
