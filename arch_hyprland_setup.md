# Arch Hyprland install and ricing

## Places to Change Manually at Install

- Start with the `hyprland.conf`. Make sure the monitors are correctly configured, your monitor setup and resolution may differ from mine. If you mouse is slow, increase the `sensitivity` value under the `input` block.
- See Hyprland binds in `~/.config/hypr/hyprland.conf` for how I control my Window manager.
- Hardcoded absolute paths with username. `/home/carl` --> `/home/username`.
- Many program configs are dependent on the pywal generated cache files. Make sure to stow pywal and
  run it. `wal -i /path/to/wallpaper -nt` or use my wallpaper script `select_wallpaper.sh`. Alternatively, remove the sourcing of pywal themes from the configs.

## Base

arch linux
wayland wayland-protocols
hyprland

```bash
# System
sudo pacman -S --needed linux-firmware pacman-contrib polkit ufw xdg-desktop-portal-hyprland xdg-desktop-portal-gtk dconf glib2 nano kitty wayland wayland-protocols sddm hyprland hyprpaper hyprlock hypridle hyprshot hyprpicker wofi waybar swaync wl-clipboard brightnessctl bluez blueman iwd NetworkManager pipewire pavucontrol tree git
# Programs
sudo pacman -S nautilus yazi firefox swayimg ffmpeg baobab spotify gimp vlc
# Font
sudo pacman -S ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd && fc-cache -fv
# Situational
sudo pacman -S fzf stow tmux ntfs-3g
# For fun
sudo pacman -S cava fastfetch pastel steam  # Steam: Remember to enable pacman multilib.

# AUR
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -r yay
# System
yay -S wlogout
# Programs
yay -S visual-studio-code-bin local-send discord heroic-games-launcher-bin caprine
# For fun
yay -S pipes.sh python-pywal python-pywalfox
```

## Window Manager Software

sddm, theme: https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/

hyprland
hyprpaper
hyprlock
hypridle
hyprshot
hyprpicker

wofi (or rofi-wayland)
waybar
wlogout (Power menu, `yay -S wlogout`.)
swaync
wl-clipboard
brightnessctl

Bluetooth stack: bluez blueman
bluez: bluetooth low-level control
blueman: gui that uses bluez

Internet stack: iwd NetworkManager
iwd: low level control, authentication and protocols
NetworkManager: higher level control, connecting ethernet wifi vpn, passwords, ip config, nmcli

Sound stack: pipewire pavucontrol
pipewire: low level control, modern, low-latency, and secure
pavucontrol: gui (orig pulseaudio but pipewire has compatibility layer)

polkit (Authentication software, used in my select_wallpaper.sh script.)
firewall: ufw (load iptables kernel modules, set rules and enable ufw)
fstrim: trim ssd (`sudo systemctl enable fstrim.timer`, `sudo systemctl start fstrim.timer`)
fastfetch


## Utility Apps

file manager: yazi / nautilus
web browser: firefox
image viewer: swayimg / feh
disk usage analyzer: baobab

vscode official (`yay -S visual-studio-code-bin`)
fzf
tmux

gimp
vlc
ffmpeg
libreoffice / openoffice
pastel (Color palette generation software run in terminal.)

spotify
caprine, see AUR
local-send (`yay -S local-send`, `sudo ufw allow 53317`)

## Ricing

stow
sudo pacman -S ttf-jetbrains-mono-nerd && fc-cache -fv
pywal (Color themes from the wallpaper, install with `sudo pacman -S python-pywal`, themes are in `~/.cache/wal/`.)
pywalfox (Both on system from yay `yay -S python-pywalfox` and as extension in Firefox. After installation, enter extension and press "Fetch theme".)
cava (Frequency bar visualizer. Install from pacman.)
pipes.sh (Pipe terminal colors visualization script. Install from yay.)
starship, also install and use the "font_family CaskadyaCove Nerd Font Mono"

### Icons

Install icon theme packages.

```bash
sudo pacman -S adwaita-icon-theme
ls /usr/share/icons
```

Alternatively:
1) Download themes from `kdestore`, `pling`, or `GitHub`.
2) Extract the folder and place in `/usr/share/icons`.
3) Change the owner to root `sudo chown -R root:root icon-pack-folder-name`.

Set them using `gsettings` from the `glib2` package.

```bash
sudo pacman -S glib2
gsettings set org.gnome.desktop.interface icon-theme Adwaita
```

### SDDM Themes

1) Download themes from `kdestore`, `pling`, or `GitHub`.
2) Extract the folder and place in `/usr/share/sddm/themes`.
3) Change the owner to root `sudo chown -R root:root theme-folder-name`.
4) Point to them in the `/etc/sddm.conf`.

```bash
[Theme]
Current=theme-name
```

### Nautilus Theme

Nautilus has changed default from the customizable `gtk-X.0` into `libadwaita`, which can only be light or dark. Use another file manager like `Thunar` or `Dolphin` for more customiability.

```bash
sudo pacman -S dconf
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
```

### Make Specific Window Semi-Transparent and Blurred

Run this command to get the name of the currently running apps.

```bash
hyprctl clients
```

Use this name to make its background semi-transparent, which Hyprland then blurs for you.

```bash
windowrulev2 = opacity 0.87, class:(firefox)
```

### Control Your Startup Time

Run this to find your startup time.

```bash
systemd-analyze
```

Process by process.

```bash
systemd-analyze blame
```

Find possible culprit and disable their autostart, or uninstall them.

```bash
sudo systemctl disable wpa_supplicant  # Given you are using iwd instead.
```

## Games

Steam:
`sudo pacman -S steam`
Also, enable pacman multilib by uncomment rows in a config file.

Heroic Games Launcher:
`yay heroic-games-launcher-bin`

discord, see AUR

## Add Custom Binaries to App Launchers

Add a symlink in `~/.local/bin` to your binary.

```bash
mkdir -p ~/.local/bin

ln -s ~/git/Cemu/bin/Cemu_release ~/.local/bin/cemu

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

Add desktop entry file to `~/.local/share/applications` and make it executable.

```bash
nano ~/.local/share/applications/cemu.desktop

chmod +x ~/.local/share/applications/cemu.desktop
```

```bash
[Desktop Entry]
Name=Cemu
Comment=Wii U Emulator
Exec=/home/username/.local/bin/cemu
Icon=/absolute/path/to/icon.ico
Terminal=false
Type=Application
Categories=Game;Emulator;
Keywords=wii;wiiu;emulator;nintendo;
StartupNotify=true
```

For keywords, use your own search words. For categories, see freedesktop.org's [registry](https://specifications.freedesktop.org/menu-spec/latest/category-registry.html).

If you run into errors, run this command to validate the entry.

```bash
desktop-file-validate ~/.local/share/applications/cemu.desktop
```