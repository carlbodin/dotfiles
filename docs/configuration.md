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

Hibernation has some prerequisites. During `archinstall`, if you (1) setup a separate
swap partition, (2) run the `systemd bootloader`, and (3) not have NVIDIA GPU,
hibernation will work out of the box. But if any of these conditions are not met, this
section will guide you in setting your system up for hibernation after the `archinstall`
process.

- Note that you cannot hibernate on ZRAM swap.
- The swap needs to possibly fit your full RAM.

Reboot before trying it out, then test with `systemctl hibernate`.

### Create Swapfile

Prefer swap on a separate partition for robustness. That way you can point to a disk
UUID instead of pointing to specific disk offsets, which may become stale after system
updates. This section guides you through creation of a swapfile on the OS partition, in
case you did not create a separate swap partition.

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

### GRUB

Prefer `systemd-boot` bootloader before `GRUB`

Find your root partition UUID and swap file offset.

```bash
findmnt -no UUID -T /swapfile
sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
```

Edit `/etc/default/grub` and change this line:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=<YOUR-ROOT-UUID> resume_offset=<YOUR-OFFSET>"
```

Note the double equal signs `=UUID=` in the resume setting.

Edit `/etc/mkinitcpio.conf` and add `resume` hook AFTER `udev` and `filesystems`:

```bash
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)
```

Rebuilt `initramfs`.

```bash
sudo mkinitcpio -P
```

Regenerate `GRUB` config:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### NVIDIA GPU

For NVIDIA GPUs, create the file `nvidia-hibernate.conf` in `/etc/modprobe.d/` to ensure
the settings are accessible during boot. Enter the configuration:

```bash
options nvidia NVreg_PreserveVideoMemoryAllocations=1
options nvidia NVreg_TemporaryFilePath=/var/tmp
```

`NVreg_TemporaryFilePath=/var/tmp` ensures persistent storage of the hibernation image,
compared to `/tmp` which is wiped on reboot.

Rebuild the `initramfs`.

```bash
sudo mkinitcpio -P
```
