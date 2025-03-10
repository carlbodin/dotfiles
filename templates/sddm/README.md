# Guide

Browse themes on [KDE Store](https://store.kde.org/browse?cat=101&ord=rating) or on
GitHub, e.g., Keyitdev's
[sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme).

How to install sddm and the `eucalyptus-drop` theme from Gitlab.

1. Download the zip package from the
   [_releases_](https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/-/releases) page.
2. Extract the zip.
3. Move the folder inside, named _eucalyptus-drop_, to `/usr/share/sddm/themes` and
   point to them using `/etc/sddm.conf`.

Edit the `/etc/sddm.conf` file to:

```bash
[Theme]
Current=eucalyptus-drop
```

Run this to end the current session and see whether the theme has been set successfully:

```bash
sudo systemctl restart sddm
```

To customize the theme, edit the `/usr/share/sddm/themes/<theme-name>/theme.conf` file.
I like to point the background key to the one created by my `select_wallpaper.sh`
script, and a bunch of other stuff, e.g., update the screen pixel width and height,
update the font, and center the form, etc. See
`templates/sddm/usr/share/sddm/themes/eucalyptus-drop/theme.conf` for full
configuration.

I also like to make the SystemButtons assume the same color as the User icon (white in
most cases, instead of black), and also make them assume the accent color on hover with
a smooth transition. See added line 30 in
`templates/sddm/usr/share/sddm/themes/eucalyptus-drop/Components/SystemButtons.qml`.

Command to preview a modified theme without logging out.

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/eucalyptus-drop
```
