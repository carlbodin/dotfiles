# Arch Installation Guide

## 1. Prepare Bootable USB

Backup important files on the target computer.

Download iso, example mirror
[Bahnhof](https://mirror.bahnhof.net/pub/archlinux/iso/latest/archlinux-x86_64.iso).

Check checksum with and compare with
[reference checksum](https://archlinux.org/iso/latest/sha256sums.txt) on the mirror's
website.

```bash
sha256sum ~/Downloads/archlinux-x86_64.iso > myfile.txt
diff myfile.txt ~/Downloads/reference_sha256sums.txt
```

Flash usb with `dd` on linux, no need for format or make a file system. Use `Rufus` on
Windows.

First identify the target drive.

```bash
lsblk
sudo fdisk -l
```

Then assign the target USB drive in the `dd` command. Use the disk file and not the
partition.

> **NB** Use with caution! Don't wipe your other computers main disk.

```bash
sudo umount /dev/sdX
sudo dd if=~/Downloads/archlinux-x86_64.iso of=/dev/sdX bs=4M status=progrss && sudo sync
```

## 2. Archinstall

- Connect network
- Partition disk
- Keyboard layout
- Packages

Plug usb and boot into it. Choose arch x86. Connect internet. Ethernet recommended. Wifi
connect through nmcli. Create guide.

```bash
nmcli dev wifi connect "SSID" password "PASSWORD"
```

(If it doesnt connect, try:

```bash
nmcli radio wifi on
```

Run: `archinstall` locale: os language us, keyboard layout sv-latin1, encoding UTF Disk
format and partitioning

Here you can choose which partitions to keep and overwrite. For a single OS system (no
dual boot) you can use:

- part 1: fat32, 500MiB, /boot
- part 2: linux-swap, >=RAM size GiB, no mount point
- part 3: ext4, press enter for default rest of disk, / For a dual boot system, use
  instead separate boot for win and Linux systems, and a separate partition per os, but
  dont mount the ones not relevant for this install.

Authentication: create your user and make it sudo Repositories: Sweden default and add
optional multilib Programs: search with /, install nano firefox iwd networkmanager sddm
hyprland git

## 3. First boot

iwd/nm: sudo nano /etc/NetworkManager/conf.d/wifi_backend.conf """ [device]
wifi.backend=iwd """

## 4. Final touches
