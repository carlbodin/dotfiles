# General Customization Guides

## Icon Themes

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

`Nautilus` has changed default from the customizable `gtk-X.0` into `libadwaita`, which
can only be light or dark. Use another file manager like `Thunar` or `Dolphin` for more
customiability. `Nautilus` and `Baobab` (Disk Usage Analyzer) honor the
`gsettings/xdg-desktop-portal` GTK theme setting.

```bash
sudo pacman -S dconf
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
```

## GTK3.0 App Theming

Apps like `nm-connection-editor` and `blueman-manager` are GTK apps not tightly
integrated with GNOME Shell, so they might ignore the dark preference if the theme isn’t
explicitly set in a GTK config.

Add content to this file: `nano ~/.config/gtk-3.0/settings.ini`.

```bash
[Settings]
gtk-application-prefer-dark-theme=1
```

Here you could also specify GTK3.0 themes.

```bash
[Settings]
gtk-theme-name=Adwaita-dark
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

## Add Custom Shortcuts to App Launchers

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

Or add Snap's `Firefox` as default for the PDF file type.

```bash
xdg-mime default firefox_firefox.desktop application/pdf
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

## Hibernation

Hibernation has some prerequisites. During `archinstall`, if you setup a separate swap
partition and run the `systemd bootloader`, hibernation will work out of the box. But if
you did not, this guide shows you how to setup a swapfile for hibernation after the
`archinstall` process.

- Note that you cannot hibernate on ZRAM swap.
- The swap needs to possibly fit your full RAM.

Check your RAM size.

```bash
free -h
```

Create a swapfile in your filesystem's root.

```bash
sudo dd if=/dev/zero of=/swapfile bs=1M count=16384 status=progress  # 16GB, adjust as needed
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

Add to `/etc/fstab`:

```plaintext
/swapfile none swap defaults 0 0
```

Find your root partition UUID and swap file offset.

```bash
findmnt -no UUID -T /swapfile
sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
```

Edit `/etc/default/grub` and change this line:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=<YOUR-ROOT-UUID> resume_offset=<YOUR-OFFSET>"
```

Edit `/etc/mkinitcpio.conf` and add `resume` hook AFTER `udev`:

```bash
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)
```

Regenerate GRUB config:

```bash
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot before trying it out. Then test with systemctl hibernate. The key is getting that
`GRUB` `resume=` parameter pointing to your actual disk swap.

## Gamescope Microcompositor

Not all desktop environments or window managers are optimized for gaming. Gamescope is a
microcompositor to solve this problem. It creates an isolated graphical environment that
has its own rendering pipeline, regardless of any other compositors in an OS. Gamescope
bring compatibility, ease of configuration, and sometimes added graphical functionality.

```bash
sudo pacman -S gamescope
```

Common flags.

```bash
-h 1080                 # Rendered height.
-w 1920                 # Rendered width.
-H 1440                 # Output height. Use for scaling.
-W 2560                 # Output width.

-S, --scaler            # Upscaler type (auto, integer, fit, fill, stretch)
-F, --filter            # Upscaler filter (linear, nearest, fsr, nis, pixel)
                        #   fsr => AMD FidelityFX™ Super Resolution 1.0
                        #   nis => NVIDIA Image Scaling v1.0.3
--sharpness, --fsr-sharpness   # Upscaler sharpness from 0 (max) to 20 (min).

-s, --mouse-sensitivity # Multiply mouse movement by given decimal number.
--framerate-limit 60    # Set a simple framerate limit.
--mangoapp              # Launch with the mangoapp.
--adaptive-sync         # Enable adaptive sync if available (VRR).

-f                      # Make the window fullscreen.
-b, --borderless        # Make the window borderless.

-g, --grab              # Grab keyboard.
--force-grab-cursor     # Grab mouse cursor.
-O, --prefer-output     # List monitor prio: DP-1, HDMI-A-1
```

### Use in Heroic Games Launcher

Example usage in Heroic with dummy arguments.

```bash
# NAME     |  # ARGS
gamescope  |  -w 3440 -h 1440 --force-grab-cursor -f --
```

### Use in Steam

Example usage in Steam with dummy arguments.

```bash
gamescope -w 1920 -h 1080 -W 2560 -H 1440 -F nis -O DP-1 -f -- %command%
```

## Use in terminal

Example usage in terminal with dummy arguments.

```bash
gamescope -w 1920 -h 1080 -b --mangoapp --adaptive-sync -- </path/to/game/binary>
```
