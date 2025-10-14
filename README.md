# Arch Hyprland Dotfiles

<img src="preview/kitty_fastfetch_pipes_cava.jpg" alt="kitty fastfetch pipes cava" width="410"><img src="preview/waybar_swaync_wofi.jpg" alt="waybar swaync wofi" width="410">
<img src="preview/sddm.jpg" alt="sddm" width="410"><img src="preview/wlogout.jpg" alt="wlogout" width="410">

## Content

- Stowable dotfiles, see `docs/stow.md` if this does not tell you anything.
- Bash utility scripts for stow. Placed in project root. Please read them carefully
  before use!
- Templates for some software settings.
- README Preview images.

## Getting Started

- Backup your current dotfiles. You can use my script `backup-local-dotfiles.sh`, if you
  dare, to copy relevant files to `~/.local-dotfiles-backup`.
- Start with the `hyprland.conf`. Make sure the monitors are correctly configured, your
  monitor setup and resolution may differ from mine. If you mouse is slow, increase the
  `sensitivity` value under the `input` block.
- See Hyprland binds in `~/.config/hypr/hyprland.conf` for how I control my Window
  manager.
- Hardcoded absolute paths with username. `/home/carl` --> `/home/username`.
- Many program configs are dependent on the pywal generated cache files. Make sure to
  stow pywal and run it. `wal -i /path/to/wallpaper -nt` or use my wallpaper script
  `select_wallpaper.sh`. Alternatively, remove the sourcing of pywal themes from the
  configs.

1. Use pacman to install "System base" and "Window manager" packages listed below.
2. Install `yay`, or your helper of choice, to allow AUR downloads.
3. Use `yay` to install `wlogout` and `pywal`.
4. Clone this repo to your home folder,
   `git clone --depth 1 https://github.com/carlbodin/dotfiles`.
5. Use `stow` to setup configurations for all apps, see guide in `docs/stow.md`. You can
   use my `backup-local-dotfiles.sh` script to backup eventual local copies of the
   relevant dotfiles. Hyprland's config `~/.config/hypr/hyprland.conf` already exists,
   so that needs to be removed prior to stowing. You can always find their default
   config [here](https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf). It
   is a bit tricky to work with `~/.config/hypr/hyprland.conf`, since it reloads on
   save. If you run into problems where it seems to not reload properly, run
   `hyprctl reload`.
6. Install the rest of the packages in which ever order you would like. I recommend this
   order because of some nested dependencies I have with background images and pywal
   color palettes for many of my programs.
7. Extra configuration options in `docs/configuration.md`. Happy ricing!

## Base System Software

Install commands for the base system software and some nice to have applications.

`Pacman` packages:

```bash
# System base
sudo pacman -S --needed pacman-contrib wayland-protocols qt6 qt6-wayland xdg-utils xdg-desktop-portal-hyprland xdg-desktop-portal-gtk nano iwd networkmanager wget pipewire
# Window manager
sudo pacman -S sddm hyprland hyprpaper hyprlock hypridle hyprshot hyprpicker kitty nautilus wofi waybar swaync wl-clipboard brightnessctl pavucontrol nm-connection-editor blueman
# I always install
sudo pacman -S fzf htop git less openssh stow firefox swayimg baobab fastfetch ffmpeg ufw man-db
# Utility
sudo pacman -S docker tmux btop starship ntfs-3g tree steam  # Steam: Remember to enable pacman multilib.
# Programs
sudo pacman -S vlc gimp spotify
# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd && fc-cache -fv
```

`AUR` packages:

```bash
# YAY and AUR
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && sudo rm -r yay
# System
yay -S wlogout
# Programs
yay -S visual-studio-code-bin discord localsend heroic-games-launcher-bin
```

## Window Manager Software

Overview of the system in text.

#### Window Manager

```
hyprland
hyprpaper
hyprlock
hypridle
hyprshot
hyprpicker
```

```
sddm
wofi (or rofi-wayland)
waybar
wlogout (Power menu, `yay -S wlogout`.)
swaync
wl-clipboard
brightnessctl
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

Use compatibility layer for pulseaudio.

```
pipewire: low level control, modern, low-latency, and secure
pavucontrol: gui (orig pulseaudio but pipewire has compatibility layer)
```

#### Other System Tools

```
polkit (Authentication software, used in my select_wallpaper.sh script.)
firewall: ufw (load iptables kernel modules, set rules and enable ufw)
fstrim: trim ssd (`sudo systemctl enable fstrim.timer`, `sudo systemctl start fstrim.timer`)
```

### Utility Apps

```
file manager: nautilus
web browser: firefox
image viewer: swayimg / feh
disk usage analyzer: baobab

fzf
htop
btop
tmux
fastfetch
man (pacman man-db)
```

For fun.

```
cowsay
fortune (pacman fortune-mod)
```

### Programs

```
vscode official (`yay -S visual-studio-code-bin`)
gimp
vlc
ffmpeg
libreoffice / openoffice
pastel (Color palette generation software run in terminal.)

spotify
caprine, see AUR
localsend (`yay -S localsend`, `sudo ufw allow 53317`)
```

### Ricing Software

JetBrainsMono Font: `sudo pacman -S ttf-jetbrains-mono-nerd && fc-cache -fv`.

```
stow
pywal (Color themes from the wallpaper, install with `sudo pacman -S python-pywal`, themes are in `~/.cache/wal/`.)
pywalfox (Both on system from yay `yay -S python-pywalfox` and as extension in Firefox. After installation, enter extension and press "Fetch theme".)
starship, also install and use the "font_family CaskadyaCove Nerd Font Mono"
cava (Frequency bar visualizer. Install from pacman.)
pipes.sh (Pipe terminal colors visualization script. Install from yay.)
```

### Games

Steam: `sudo pacman -S steam` Also, enable pacman multilib by uncomment rows in a config
file.

Heroic Games Launcher: `yay heroic-games-launcher-bin`.

Discord, see AUR.

## Scripts

These scripts are available.

```bash
- backup-local-dotfiles.sh  # Save existing dotfiles to folder.
- stow-all.sh  # Stow "all" dotfiles.
- unstow-all.sh  # Remove stowed dotfiles.
```

The local bashrc versions, `penguin` and `rpi4`, are not included in `stow-all.sh`.
