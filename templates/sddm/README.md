# Simple Desktop Display Manager

## Example Theme: Eucalyptus Drop

Install `SDDM` and dependencies, I choose to install the whole `QT6` ecosystem.

```bash
sudo pacman -S sddm qt6
```

Change directory to the themes folder `/usr/share/sddm/themes` and clone the repo.

```bash
git clone --depth 1 https://gitlab.com/carlbodin/sddm-eucalyptus-drop
```

Enable the theme editing `/etc/sddm.conf` like this:

```bash
[Theme]
Current=sddm-eucalyptus-drop
```

### Stow SDDM Configs

```bash
stow -d ~/dotfiles/templates -t / sddm
```

### Theme Customization

To customize the theme, edit the `/usr/share/sddm/themes/<theme-name>/theme.conf` file.
I like to point the background key to the one created by my `select_wallpaper.sh`
script, and a bunch of other stuff, e.g., update the screen pixel width and height,
update the font, and center the form, etc. See
`templates/sddm/usr/share/sddm/themes/sddm-eucalyptus-drop/theme.conf` for full
configuration.

I also like to make the SystemButtons assume the same color as the User icon (white in
most cases, instead of black), and also make them assume the accent color on hover with
a smooth transition. See added line 30 in
`templates/sddm/usr/share/sddm/themes/eucalyptus-drop/Components/SystemButtons.qml`.

Command to preview a modified theme without logging out.

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm-eucalyptus-drop
```

## Browse Other Themes

Browse themes on [KDE Store](https://store.kde.org/browse?cat=101&ord=rating) or on
GitHub, e.g., Keyitdev's
[sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme).

1. Download the zip.
2. Extract it, e.g.
   `sudo pacman -S --needed unzip && unzip ~/Downloads/<theme-name>.zip`.
3. Move the folder to the `SDDM` library:
   `sudo mv ~/Downloads/<theme-name> /usr/share/sddm/themes/`.
4. Enable the theme using `/etc/sddm.conf` like described in the section above.
