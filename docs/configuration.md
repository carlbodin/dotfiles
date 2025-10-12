# General Customization Guides

## Icons

Install icon theme packages.

```bash
sudo pacman -S adwaita-icon-theme
ls /usr/share/icons
```

Alternatively:

1. Download themes from `kdestore`, `pling`, or `GitHub`.
2. Extract the folder and place in `/usr/share/icons`.
3. Change the owner to root `sudo chown -R root:root icon-pack-folder-name`.

Set them using `gsettings` from the `glib2` package.

```bash
sudo pacman -S glib2
gsettings set org.gnome.desktop.interface icon-theme Adwaita
```

## SDDM Themes

1. Download themes from `kdestore`, `pling`, or `GitHub`.
2. Extract the folder and place in `/usr/share/sddm/themes`.
3. Change the owner to root `sudo chown -R root:root theme-folder-name`.
4. Point to them in the `/etc/sddm.conf`.

```bash
[Theme]
Current=theme-name
```

`SDDM` is also shipped with three default themes: `elarun`, `maldives `, and `maya`. But
these are aweful.

## Nautilus Theme

Nautilus has changed default from the customizable `gtk-X.0` into `libadwaita`, which
can only be light or dark. Use another file manager like `Thunar` or `Dolphin` for more
customiability.

```bash
sudo pacman -S dconf
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
```

## Make Specific Window Semi-Transparent and Blurred

Run this command to get the name of the currently running apps.

```bash
hyprctl clients
```

Use this name to make its background semi-transparent, which Hyprland then blurs for
you.

```bash
windowrulev2 = opacity 0.95, class:(Spotify)
```

## Control Your Startup Time

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

For keywords, use your own search words. For categories, see freedesktop.org's
[registry](https://specifications.freedesktop.org/menu-spec/latest/category-registry.html).

If you run into errors, run this command to validate the entry.

```bash
desktop-file-validate ~/.local/share/applications/cemu.desktop
```

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
