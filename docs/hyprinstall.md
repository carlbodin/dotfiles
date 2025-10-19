# Install Hyprland

This is a guide to install the Hyprland Window Manager on a minimalistic arch linux OS.

## Step-by-step Guide

To see the packages go to section [Base System Software](#base-system-software) below.

Backup your current dotfiles. You can use my script `backup-local-dotfiles.sh`, to copy
relevant files to `~/dotfiles/local-dotfiles-backup/`.

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
6. Install the rest of the packages in which ever order you like. I recommend this order
   because of some nested dependencies I have with background images and pywal color
   palettes for multiple programs.
7. There are even further configuration options described in `docs/configuration.md`.
   Happy ricing!

## Packages

Core system packages with complete `pacman` install commands.

#### Pacman Packages

```bash
# System base
sudo pacman -S --needed pacman-contrib wayland-protocols qt6 qt6-wayland xdg-utils xdg-desktop-portal-hyprland xdg-desktop-portal-gtk nano iwd networkmanager wget pipewire
# Window manager
sudo pacman -S sddm hyprland hyprpaper hyprlock hypridle hyprshot hyprpicker kitty nautilus wofi waybar swaync wl-clipboard brightnessctl pavucontrol nm-connection-editor blueman
# I always install
sudo pacman -S fzf htop git less openssh stow firefox swayimg baobab fastfetch ffmpeg ufw man-db
# Utility
sudo pacman -S docker tmux btop starship fd ripgrep zoxide ntfs-3g tree steam  # Steam: Remember to enable pacman multilib.
# Programs
sudo pacman -S vlc gimp spotify
# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd && fc-cache -fv
```

#### AUR Packages

```bash
# YAY and AUR
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && sudo rm -r yay
# System
yay -S wlogout
# Programs
yay -S visual-studio-code-bin discord localsend heroic-games-launcher-bin
```

## Window Manager Software

Alternative view of the system in text blocks with descriptions.

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

Audio server `pipewire` will use a compatibility layer for `pulseaudio`.

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

Generally useful GUI tools.

```
file manager: nautilus
web browser: firefox
image viewer: swayimg / feh
disk usage analyzer: baobab
```

Generally useful terminal tools.

```
fzf
htop
btop
tmux
fastfetch
fd (file and folder search)
ripgrep (file content search)
zoxide (smart cd)
man (pacman man-db)
pastel (Color palette generation software run in terminal.)
```

Generally un-useful tools.

```
cowsay
fortune (pacman fortune-mod)
```

### Apps

```
vscode official (`yay -S visual-studio-code-bin`)
gimp
vlc
libreoffice / openoffice
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
