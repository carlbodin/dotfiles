# Cemu on Arch

A guide to installing, configuring, and using Cemu (Wii U emulator) on
Arch Linux with wiiudownloader for game management.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Setting Up wiiudownloader](#setting-up-wiiudownloader)
- [Downloading Games](#downloading-games)
- [Initial Cemu Configuration](#initial-cemu-configuration)
- [Loading Games in Cemu](#loading-games-in-cemu)
- [Installing Updates and DLC](#installing-updates-and-dlc)
- [Graphics Packs & Mods](#graphics-packs--mods)
- [Game Settings & Optimization](#game-settings--optimization)
- [Controller Setup](#controller-setup)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before installing Cemu, ensure your system meets these requirements:

- **CPU**: Modern x64 CPU with good single-core performance
- **GPU**: OpenGL 4.5 or Vulkan 1.2 compatible graphics card
- **RAM**: At least 8GB (16GB recommended)
- **Storage**: 50GB+ free space for games
- **Internet**: For downloading game files via wiiudownloader

## Installation

### Installing Cemu via AUR

```bash
# Install yay if you don't have it
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install Cemu
yay -S cemu
```

## Setting Up wiiudownloader

wiiudownloader is a GUI application that downloads Wii U games, updates, and DLC
directly from Nintendo's servers using your title keys.

### Installing wiiudownloader (GUI)

1. **Download the AppImage**:

   - Visit: https://github.com/Xpl0itU/WiiUDownloader
   - Go to Releases and download the latest `WiiUDownloader-*.AppImage`

2. **Make it executable**:

   ```bash
   mkdir -p ~/Applications
   mv ~/Downloads/WiiUDownloader-*.AppImage ~/Applications/
   chmod +x ~/Applications/WiiUDownloader-*.AppImage
   ```

3. **Create a desktop entry** (optional, for app launcher):

   ```bash
   mkdir -p ~/.local/share/applications
   cat > ~/.local/share/applications/wiiudownloader.desktop << 'EOF'
   [Desktop Entry]
   Name=WiiU Downloader
   Comment=Download Wii U titles from Nintendo's servers
   Exec=/home/YOUR_USERNAME/Applications/WiiUDownloader-*.AppImage
   Icon=wiiu
   Terminal=false
   Type=Application
   Categories=Game;Utility;
   EOF

   # Replace YOUR_USERNAME with your actual username
   sed -i "s/YOUR_USERNAME/$USER/g" ~/.local/share/applications/wiiudownloader.desktop
   ```

4. **Launch wiiudownloader**:
   ```bash
   ~/Applications/WiiUDownloader-*.AppImage
   ```

For detailed setup instructions, see the
[wiiudownloader user guide](https://xpl0itu.github.io/WiiUDownloaderDocs/docs/)

### Understanding Title IDs

Each Wii U title has a unique ID:

- **Base games**: Start with `00050000`
- **Updates**: Start with `0005000E`
- **DLC**: Start with `0005000C`

You'll need the Title ID for the games you own to download them.

## Downloading Games

### Finding Title IDs

You can find Title IDs for games you own:

1. From the disc case or eShop purchase history
2. From online databases (for reference only - you must own the game)
3. From your Wii U console using homebrew tools

### Using wiiudownloader GUI

Create a directory for your downloads:

```bash
mkdir -p ~/WiiU-Downloads/{Games,Updates,DLC}
```

#### Downloading Games, Updates, and DLC

1. **Launch wiiudownloader**
2. **Enter the Title ID** for the game you own
3. **Select output directory**:
   - Base games → `~/WiiU-Downloads/Games/`
   - Updates → `~/WiiU-Downloads/Updates/`
   - DLC → `~/WiiU-Downloads/DLC/`
4. **Click Download**

> **IMPORTANT NOTES:**
>
> - **Always download the update** for your game if available, or the game may not work
>   (e.g., Breath of the Wild requires its update)
> - **Always check "Decrypt Contents"** - this will make files usable by Cemu
> - **Optionally check "Delete encrypted contents after decryption"** - leave unchecked
>   to keep an encrypted copy, which is not necessary for the game to run
> - **DLC is optional** and not required for games to run

For detailed usage instructions and features, see the
[wiiudownloader user guide](https://xpl0itu.github.io/WiiUDownloaderDocs/docs/)

### Organizing Downloaded Games

After downloading, your structure should look like:

```
~/WiiU-Downloads/
├── Games/
│   ├── Game Title [00050000XXXXXXXX]/
│   │   ├── code/
│   │   │   └── game.rpx
│   │   ├── content/
│   │   └── meta/
│   │       └── meta.xml
├── Updates/
│   └── Game Title Update [0005000EXXXXXXXX]/
└── DLC/
    └── Game Title DLC [0005000CXXXXXXXX]/
```

## Initial Cemu Configuration

### First Launch Setup

1. **Launch Cemu**:

   ```bash
   cemu
   ```

2. **Set Game Paths**:

   - Go to `Options` → `General Settings` → `Game Paths`
   - Click `Add` and select `~/WiiU-Downloads/Games`
   - Cemu will scan this directory and list your games

3. **Configure Graphics API**:

   - Go to `Options` → `General Settings` → `Graphics`
   - Choose **Vulkan** (recommended for better performance)

4. **Set MLC Path** (Virtual Wii U NAND):

   - Go to `Options` → `General Settings` → `MLC Path`
   - Default is `~/.local/share/cemu/mlc01` (recommended)
   - This is where updates and DLC will be installed

5. **Configure Title Keys**:
   - Go to `Options` → `General Settings` → `Account`
   - Copy your title keys to `~/.local/share/cemu/keys.txt`
   - Format:
     ```
     [TitleID in hex] = [16-byte title key in hex]
     ```

## Loading Games in Cemu

### Playing Base Games

Base games downloaded via wiiudownloader are in Loadiine format and stay in your Games
directory.

1. **From the game list**:

   - Your games should appear in Cemu's main window
   - Double-click a game to launch it

2. **Manual loading**:
   - Go to `File` → `Load`
   - Navigate to `~/WiiU-Downloads/Games/[Game Title]/code/`
   - Select the `.rpx` file

Base games are loaded directly from your Games directory - they are NOT copied or
"installed" anywhere else.

## Installing Updates and DLC

Updates and DLC need to be "installed" into Cemu's MLC path (virtual NAND storage).

### Installing Updates

1. Go to `File` → `Install game title, update or DLC`
2. Navigate to `~/WiiU-Downloads/Updates/[Update Title]/meta/`
3. Select `meta.xml`
4. Cemu will copy the update files to
   `~/.local/share/cemu/mlc01/usr/title/0005000E/[TitleID]/`

### Installing DLC

1. Go to `File` → `Install game title, update or DLC`
2. Navigate to `~/WiiU-Downloads/DLC/[DLC Title]/meta/`
3. Select `meta.xml`
4. Cemu will copy the DLC files to
   `~/.local/share/cemu/mlc01/usr/title/0005000C/[TitleID]/`

### Verifying Installation

After installing updates/DLC:

- Right-click the game in Cemu's game list
- Select `Game directory` to see which version is active
- Updates and DLC will automatically be detected and applied when you launch the base
  game

## Graphics Packs & Mods

### Downloading Graphics Packs

Graphics packs provide enhancements like resolution mods, FPS unlocks, and visual
improvements.

1. Go to `Options` → `Graphics Packs`
2. Click `Download community graphics packs`
3. Select the packs you want to enable for each game

### Recommended Graphics Packs

- **Resolution mods**: 1080p, 1440p, or 4K
- **FPS++**: Unlocks frame rate (for compatible games)
- **Enhanced Reflections**: Improves reflection quality
- **Anti-Aliasing**: FXAA or better AA methods

### Manual Installation

```bash
cd ~/.local/share/cemu/graphicPacks
git clone https://github.com/ActualMandM/cemu_graphic_packs.git downloadedGraphicPacks
```

## Game Settings & Optimization

### Per-Game Configuration

Right-click a game → `Edit game profile`:

1. **CPU Mode**:

   - Single-core interpreter (most compatible, slowest)
   - Triple-core recompiler (best performance)

2. **Thread Quantum**:

   - Set to 100000 for better performance
   - Lower values may improve compatibility

3. **GPU Buffer Cache Accuracy**:
   - Low (fastest, may cause glitches)
   - Medium (balanced)
   - High (most accurate, slight performance cost)

### General Performance Settings

1. **Options** → **General Settings**:
   - **Upscale/Downscale Filter**: Bilinear (balanced) or Bicubic (better quality)
   - **Async Shader Compilation**: Enable (reduces stuttering)
   - **VSync**: Disable for best performance, enable to reduce tearing

### Shader Cache

Cemu builds a shader cache on first run. For smoother gameplay:

- Pre-compiled shader caches can be downloaded online
- Place them in: `~/.local/share/cemu/shaderCache/transferable/`
- Format: `[TitleID].bin`

The first time you play a game, expect some stuttering as shaders compile. This improves
after the first playthrough.

## Controller Setup

### Setting Up Controllers

1. Go to `Options` → `Input Settings`
2. Select `Emulated Controller`: Wii U GamePad or Pro Controller
3. Choose your controller from the `Controller` dropdown
4. Click each button and press the corresponding button on your controller

### Controller Options

- **DualShock 4/DualSense**: Works via Bluetooth or USB
- **Xbox Controllers**: Native support
- **Nintendo Switch Pro Controller**: Works via Bluetooth
- **Keyboard**: Can be configured as controller

### Motion Controls

For games requiring gyro (like Breath of the Wild):

1. Use a controller with gyro support (DS4, DualSense, Switch Pro)
2. In Input Settings, enable motion source
3. Configure motion controls by following on-screen prompts

## Troubleshooting

### Common Issues

**Game crashes or won't launch:**

- Verify download completed successfully (check file sizes)
- Ensure title keys are correct in `keys.txt`
- Try different CPU modes (Single-core vs Triple-core)
- Update Cemu to latest version: `yay -S cemu`

**Poor performance:**

- Switch to Vulkan renderer
- Enable async shader compilation
- Lower resolution in graphics packs
- Close background applications
- Ensure GPU drivers are up to date:

  ```bash
  # NVIDIA
  sudo pacman -S nvidia nvidia-utils

  # AMD
  sudo pacman -S mesa vulkan-radeon

  # Intel
  sudo pacman -S mesa vulkan-intel
  ```

**Graphics glitches:**

- Adjust GPU buffer cache accuracy
- Update graphics packs
- Try different graphics API (OpenGL vs Vulkan)

**Audio issues:**

- Go to `Options` → `General Settings` → `Audio`
- Try different audio backends
- Adjust latency settings

**Controller not detected:**

- Check if controller is recognized by system:
  ```bash
  ls /dev/input/
  jstest /dev/input/js0
  ```
- Install appropriate drivers if needed

**wiiudownloader fails:**

- Verify internet connection
- Check that Title ID and keys are correct
- Ensure sufficient disk space
- **Never use "Decrypt Contents" or "Delete encrypted contents"** - files must remain
  encrypted for Cemu
- See the
  [wiiudownloader troubleshooting guide](https://xpl0itu.github.io/WiiUDownloaderDocs/docs/)

**Updates/DLC not applying:**

- Verify they're installed (check `~/.local/share/cemu/mlc01/usr/title/`)
- Ensure Title IDs match (base game and update/DLC must correspond)
- Check that title keys are in `keys.txt`

### Log Files

Check logs for errors:

```bash
~/.local/share/cemu/log.txt
```

### Getting Help

- **Cemu Discord**: https://discord.gg/5psYsup
- **Cemu Wiki**: https://wiki.cemu.info/
- **GitHub Issues**: https://github.com/cemu-project/Cemu/issues
- **r/cemu subreddit**: https://www.reddit.com/r/cemu/

## File System Overview

Understanding where files are stored:

```
~/.local/share/cemu/
├── mlc01/                    # Virtual Wii U NAND (installed updates/DLC)
│   └── usr/
│       └── title/
│           ├── 0005000E/     # Updates
│           └── 0005000C/     # DLC
├── shaderCache/              # Compiled shaders
│   └── transferable/
├── graphicPacks/             # Graphics mods
├── keys.txt                  # Title keys
└── log.txt                   # Cemu log file

~/WiiU-Downloads/
├── Games/                    # Base games (loaded directly, not "installed")
├── Updates/                  # Downloaded updates (before installing)
└── DLC/                      # Downloaded DLC (before installing)
```

**Key Point**: Base games stay in your Games directory and are loaded from there. Only
updates and DLC get "installed" (copied) into the MLC path.

## Additional Resources

- **wiiudownloader GitHub**: https://github.com/Xpl0itU/WiiUDownloader
- **wiiudownloader User Guide**: https://xpl0itu.github.io/WiiUDownloaderDocs/docs/
- **Cemu Official Website**: https://cemu.info/
- **Cemu GitHub**: https://github.com/cemu-project/Cemu
- **Compatibility List**: https://compat.cemu.info/
- **Arch Wiki**: https://wiki.archlinux.org/title/Cemu
