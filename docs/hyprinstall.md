# Install Hyprland

This is a guide to install the Hyprland Window Manager on a minimalistic arch linux OS.

## Step-by-step Guide

To see the packages go to section [Base System Software](#base-system-software) below.

Backup your current dotfiles. You can use my script `backup-local-dotfiles.sh`, to copy
relevant files to `~/dotfiles/local-dotfiles-backup/`.

1. Use pacman to install "System base" and "Window manager" packages listed below.
2. Install `yay`, or your helper of choice, to allow AUR downloads.
3. Use `yay` to install `wlogout` and `pywal`. Then run
   `wal -st -i ~/.config/hypr/select_wallpaper.jpg`. Do this on your own wallpaper in
   bullet (6) below.
4. Clone this repo to your home folder,
   `git clone --depth 1 https://github.com/carlbodin/dotfiles`.
5. Use `stow` to setup configurations for all apps, see guide in `docs/stow.md`. You can
   use my `backup-local-dotfiles.sh` script to backup eventual local copies of the
   relevant dotfiles. Hyprland's config `~/.config/hypr/hyprland.conf` already exists,
   so that needs to be removed prior to stowing. You can always find their default
   config [here](https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf).
   This config reloads on save. If you run into problems where it seems to not reload
   properly, run `hyprctl reload`.
6. With `pywal` and `select-wallpaper` stowed, run the `select_wallpaper.sh` script to
   generate pywal. This is bound to the key combination `shift` + `mainMod` + `W`. This
   assumes you have images in `~/Pictures/wallpapers`.
7. Install the rest of the packages in which ever order you like. I recommend this order
   because of some nested dependencies I have with background images and pywal color
   palettes for multiple programs.
8. There are even further configuration options described in `docs/configuration.md`.
   Happy ricing!

## Packages

Core system packages with complete `pacman` install commands.

#### Pacman Packages

```bash
# System base
sudo pacman -S --needed pacman-contrib wayland-protocols qt6 qt6-wayland xdg-utils xdg-desktop-portal-hyprland nano iwd networkmanager wget pipewire openssh git less ufw
# Window manager environment
sudo pacman -S sddm hyprland hyprpaper hyprlock hypridle hyprshot hyprpicker kitty wofi waybar swaync wl-clipboard cliphist brightnessctl pavucontrol nm-connection-editor blueman xdg-desktop-portal-gtk nautilus baobab man-db htop firefox fzf swayimg python-pywal
# Utility
sudo pacman -S stow fastfetch ffmpeg wf-recorder docker tmux btop starship fd ripgrep zoxide ntfs-3g tree git-lfs tldr
# Apps
sudo pacman -S vlc gimp spotify libreoffice-fresh steam  # Steam: Remember to enable pacman multilib.
# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd && fc-cache -fv
```

#### AUR Packages

```bash
# Install yay for AUR access
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && sudo rm -r yay
# System
yay -S wlogout python-pywalfox
# Apps
yay -S visual-studio-code-bin discord localsend heroic-games-launcher-bin
```

## Window Manager Software

Alternative view of the system in text blocks with descriptions.

#### Window Manager

```
hypridle
hyprland
hyprlock
hyprpaper
hyprpicker
hyprshot
```

```
brightnessctl
cliphist
sddm
swaync
ufw (load iptables kernel modules, set rules and enable ufw)
waybar
wl-clipboard
wlogout
wofi
```

#### Bluetooth stack

```
bluez: bluetooth low-level control
blueman: gui that uses bluez
```

#### Internet stack

```
iwd: Low level control, authentication, and protocols.
NetworkManager: Higher level control, connecting ethernet wifi vpn, passwords, ip config, nmcli.
```

#### Sound stack

Audio server `pipewire` will use a compatibility layer for `pulseaudio`.

```
pipewire: low level control, modern, low-latency, and secure
pavucontrol: gui (orig pulseaudio but pipewire has compatibility layer)
```

### Utility Apps

Generally useful GUI tools.

```
disk usage analyzer: baobab
file manager: nautilus
image viewer: swayimg / feh
web browser: firefox
```

Generally useful terminal tools.

```
btop
fastfetch (System info)
fd (Search file and folder names fast)
fzf (Search in shell history)
git-lfs
htop
man
ripgrep (Search file content fast)
tldr (Summarized manual page with examples.)
tmux
pastel (Color palette generator)
wf-recorder (Wayland screenrecorder: `wf-recorder -f output.mp4`)
zoxide (Smart cd)
```

Generally un-useful tools.

```
cava (Frequency bar visualizer. Install from pacman.)
cowsay (Funny quote generator)
fortune (pacman fortune-mod)
pipes.sh (Pipe visualization script of terminal colors, install from yay)
```

### Apps

```
localsend (Make port in firewall: `sudo ufw allow 53317`)
gimp (Photo editing)
spotify
vlc (Media player)
vscode official
```

LibreOffice suite, an open-source variant of the MicrosoftOffice suite.

```bash
sudo pacman -S libreoffice-fresh           # All programs
sudo pacman -S libreoffice-still-writer    # Only word processor
sudo pacman -S libreoffice-still-calc      # Only spreadsheet
sudo pacman -S libreoffice-still-impress   # Only presentations
```

### Ricing Software

JetBrainsMono Font: `sudo pacman -S ttf-jetbrains-mono-nerd && fc-cache -fv`.

```
stow
pywal (Color themes from the wallpaper, themes are in `~/.cache/wal/` and templates in `~/.config/wal/`)
pywalfox (Also install as extension in Firefox)
starship (Requires CaskadyaCove Nerd Font Mono)
```

### Games

Steam: `sudo pacman -S steam` Also, enable pacman multilib by uncomment rows in a config
file.

Heroic Games Launcher (Can connect to EpicGames)

Discord
