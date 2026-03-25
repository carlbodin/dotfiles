# Arch Installation Guide

How to install arch linux on your machine.

Prerequisites:

- Internet connection
- Target hardware, where `archlinux` should be installed
- USB drive
- A unit for downloading the ISO and preparing the USB drive on, may be the same as the
  target

## 1. Prepare Bootable USB

> This guide assumes that you use a linux OS.

Backup important files on the target computer.

#### 1.1 Download ISO

Download the latest `archlinux` ISO, example mirror
[Bahnhof](https://mirror.bahnhof.net/pub/archlinux/iso/latest/archlinux-x86_64.iso).
Compare checksums with the
[official reference](https://archlinux.org/iso/latest/sha256sums.txt). Here are some
example commands for the checksum comparison, assuming both ISO and checksum reference
are located in the `~/Downloads/` folder.

```bash
sha256sum ~/Downloads/archlinux-x86_64.iso > myfile.txt
diff myfile.txt ~/Downloads/reference_sha256sums.txt
```

#### 1.2 Flash Bootable Image

Flash the bootable ISO image onto your USB drive. You could, e.g., use `dd`. On Windows
there are tools like `Rufus`. There is no need for manually format the USB drive nor
create any file systems in it. Make sure to backup any files you want to keep on the USB
drive, it will be completely wiped.

First identify the USB drive on your machine. Use tools like:

```bash
lsblk
sudo fdisk -l
```

Unmount the USB drive. Then use the drive as the output file in the `dd` command. Refer
to it by the disk file and not any partitions, see command below. Change paths if
needed.

```bash
# Use with caution! Don't wipe any other disks than you intend to.
sudo umount /dev/sdX  # Change X to the appropriate letter.
sudo dd if=~/Downloads/archlinux-x86_64.iso of=/dev/sdX bs=4M status=progrss && sudo sync
```

The bootable USB is now prepared and ready for use. Plug it into the target hardware and
boot into it. This is either automatically detected, or you need to boot into UEFI and
then choose to boot from the USB.

## 2. Archinstall

#### 2.1 Boot Into the USB Drive

When you have successfully booted into the USB drive, choose the "Arch Linux install
medium (x86_64, UEFI)" entry.

#### 2.2 Connect to Internet

Connect to the internet, ethernet is recommended. If you want to use wifi, you can use
`iwd`. Start the program.

```bash
iwctl
```

List your hardware devices.

```bash
device list
# Usual output is wlan0 and loopback.
```

Use this device to scan and report available networks.

```bash
station wlan0 scan
station wlan0 get-networks
```

Connect to your network.

```bash
station wlan0 connect "SSID"
# Enter password when prompted.
```

Verify the connection.

```bash
ping 1.1.1.1
```

Troubleshoot networking errors on failure, or connect with ethernet to continue.

#### 2.3 Run the Archinstall

Start by running the command `archinstall`.

##### 2.3.1 Archinstall Language

The language of the displayed options during this installation process.

##### 2.3.2 Locales

**Keyboard layout:** Choose `sv-latin1` for Swedish.

**Locale language:** Choose `en_US` for home folder file system and OS tools in English.

**Encoding:** Choose `UTF`, I don't know why you wouldn't.

##### 2.3.3 Mirrors

These are pacman repository mirror regions. Choose somewhere close to you for lower
latency during package install and upgrades.

##### 2.3.4 Disk Configuration

This sections is for disk partitioning and formatting. I choose to do "Manual
Partitioning" for more granular control.

Here you can choose which partitions to keep and overwrite. For a single OS system (no
dual-boot) you can use:

    PARTITION    FILESYSTEM    SIZE        MOUNT POINT

    part 1       fat32         500MiB      /boot

    part 2       linux-swap    >=RAM       Skip

    part 3       ext4          The rest    /

For a dual-boot system, use instead separate boot for win and Linux systems, and a
separate partition per os, but do not mount any partitions that are not relevant for
this install. E.g., dual-boot setup.

    PARTITION    FILESYSTEM     SIZE        MOUNT POINT    PURPOSE

    part 1       fat32          500MiB      Skip           Windows bootloader

    part 2       ntfs           XXX GB      Skip           Windows file system

    part 3       ntfs           XX GB       Skip           Windows recovery

    part 4       fat32          500MiB      /boot          Linux bootloader

    part 5       linux-swap     >=RAM       Skip           Linux OS swap

    part 6       ext4           The rest    /              Linux OS filesystem

##### 2.3.5 Disk Encryption

I do not use this.

##### 2.3.6 Swap

To swap on `ZRAM`. I do not use this, since I do not have minimal RAM. Also, my swap is
already configured in section [2.3.4 Disk Configuration](#234-disk-configuration) above.

Swapping without ZRAM and on a separate partition is the must robust and compatible
setup for hibernation to work properly. See
[docs/configuration.md](/docs/configuration.md) for more details on setting up
hibernation.

##### 2.3.7 Bootloader

Choose `systemd-boot` on single OS systems, and `GRUB` on multiple OS systems (dual
boot).

##### 2.3.8 Unified Kernel Images

Disabled.

##### 2.3.9 Hostname

Local `DNS` name that can translate into your IP address. Choose a unique name for your
local network that you want to use for your machine when connecting to it.

##### 2.3.10 Root Password

Set one if you want to have the option to login as `root` from your display manager. You
can add this later.

##### 2.3.11 User Account

Create your user and make it a superuser.

##### 2.3.12 Profile

I choose minimal and build my system from scratch later, see `README.md`. Here you can
choose a preset Desktop Environment or Window Manager if you want.

##### 2.3.13 Audio

The audio server, I choose `pipewire`.

##### 2.3.14 Kernels

I choose the default: `linux`.

##### 2.3.15 Network Configuration

Copy ISO network configuration to installation.

##### 2.3.16 Additional Packages

Search programs with `/`. Suggested programs:

```
nano iwd networkmanager
```

##### 2.3.17 Optional Repositories

I do not add any other repositories. You can add the `multilib` repository here now if
you know you will run Steam `proton`, or other `Wine`-based translation layers for
graphic APIs.

To enable this later in the actual OS, edit the `/etc/pacman.conf` by uncommenting the
`[multilib]` section, and then run `pacman -Sy` to sync your new repositories.

##### 2.3.18 Timezone

Set your timezone.

##### 2.3.19 Automatic Time Sync

I choose to enable this, which also is the default.

##### 2.3.20 Install

To finish the configuration and start the actual installation process, choose `Install`.
If you for any reason want to the save exact configuration settings, you can serialize
the config to a JSON like format using `Save configuration`.

#### 2.4 Configure Bootloader (for dual-boot)

This is a dual-boot specific step. Other setups can skip this.

```bash
sudo pacman -S --needed efibootmgr os-prober
```

Edit the "user `GRUB` config", `sudo nano /etc/default/grub`, to contain this.

```plaintext
GRUB_DISABLE_OS_PROBER=false
```

Use OS prober to detect `Windows`.

```bash
sudo os-prober
```

Configure UEFI to prioritize `GRUB` on boot.

```bash
sudo efibootmgr
```

Example output:

```plaintext
BootCurrent: 0002
Timeout: 2 seconds
BootOrder: 0002,0001,0000
Boot0000* Windows Boot Manager
Boot0001* UEFI: USB
Boot0002* GRUB
```

BootOrder shows the current priority, where the first item and lowest number has the
highest priority. The `Boot000X` are your boot entries.

Set a new priority with the `-o` flag. You can list as many entries as needed in the
order you want.

```bash
sudo efibootmgr -o 0002,0000
```

Delete an entry.

```bash
sudo efibootmgr -b 0001 -B
```

Rename an entry.

```bash
sudo efibootmgr -b 0002 -L "Arch Linux (GRUB)"
```

Verify your config.

```bash
sudo efibootmgr
```

Regenerate the "system `GRUB` config".

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot and try it out. You should be able to choose which OS to launch into on boot. If
the `efibootmanager` step above did not work, configure you UEFI to boot into `GRUB`
rather than the `Windows` specific bootloader.

Troubleshooting: If your firmware ignores changes, check for a “Fast Boot” or “Windows
Boot Manager priority” option in BIOS and disable it.

## 3. First Boot

Boot into your new `archlinux` system.

If you did not copy the network configuration over to your OS from the installation
media, you will need to configure this.

Intels wireless daemon(`iwd`) is not Intel-specific, so you can configure
`NetworkManager` to use it as backend instead of its default `wpa_supplicant`. Create
this config file.

```bash
sudo nano /etc/NetworkManager/conf.d/wifi_backend.conf
```

Enter this text.

```plaintext
[device]
wifi.backend=iwd
```

Stop and disable `wpa_supplicant` and possible DHCP software like `dhcpcd`.

```bash
systemctl status wpa_supplicant dhcpcd
sudo systemctl disable --now wpa_supplicant dhcpcd
sudo pacman -Rns wpa_supplicant dhcpcd
```

Enable `NetworkManager` and `iwd` on boot.

```bash
sudo systemctl enable --now networkmanager iwd
```

Verify setup.

```bash
systemctl status wpa_supplicant dhcpcd
systemctl status networkmanager iwd
```

Now, if needed, connect to wifi using `nmcli`. First scan for available devices.

```bash
nmcli radio wifi on
nmcli device wifi list
```

Identify the `SSID` of your network and connect to it using.

```bash
nmcli dev wifi connect "SSID" password "PASSWORD"
```

Verify internet connection before continuing.

```bash
ping 1.1.1.1
```

### 3.2 Setup Hyprland

It is time to install a GUI environment. See `README.md` in the repository root to
install the Window Manager `Hyprland`.
