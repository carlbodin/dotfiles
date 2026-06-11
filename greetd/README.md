# Minimal Greeter

Required packages.

```bash
sudo pacman -S greetd greetd-regreet cage gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-uglyf
```

The greeter system user must exist — greetd creates it, but verify.

```bash
id greeter
```

Copy the config files `/etc/greetd/config.toml` and `/etc/greetd/regreet.toml` from this
repo to their expected paths. Make sure regreet's own config is readable by the greeter
user.

```bash
sudo cp greetd/etc/greetd/config.toml greetd/etc/greetd/regreet.toml /etc/greetd
sudo chown greeter: /etc/greetd/regreet.toml
```

Set the wallpaper.

```bash
sudo mkdir -p /usr/share/wallpapers
sudo cp your/wallpaper.jpg /usr/share/wallpapers/selected_wallpaper.jpg
```

Make sure the `greeter` user can read it.

```bash
sudo -u greeter ls /usr/share/wallpapers/selected_wallpaper.jpg
```

Disable current display manager and enable `greetd`.

```bash
sudo systemctl disable sddm
sudo systemctl enable greetd
```

Troubleshooting.

```bash
journalctl -u greetd -b -1
```
