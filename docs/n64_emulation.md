# Simple64 N64 on Arch

## Installing Simple64

Simple64 is a modern, user-friendly N64 emulator with excellent compatibility and a
clean interface.

```bash
yay -S simple64
```

## Setting Up Your Game Library

Create a directory structure for your ROMs:

```bash
mkdir -p ~/Games/n64/roms
```

Place your `.z64`, `.n64`, or `.v64` ROM files in `~/Games/n64/roms/`. Game roms can be
downloaded from [RomsGames](https://www.romsgames.net/roms/nintendo-64/).

## Running Games

1. Launch Simple64 from your application menu or terminal:

```bash
simple64
```

2. **First time setup:**

   - Go to Settings → Configure Paths
   - Set ROM directory to `~/Games/n64/roms/`
   - Your game library will appear in the main window

3. **Playing games:**
   - Double-click any game to launch
   - Or: File → Open ROM → select game manually

## Controller Configuration

### Setting Up Your Controller

1. Connect your controller (USB or Bluetooth)
2. In Simple64: Settings → Input Settings
3. Click "Configure Controller" for Player 1
4. Map buttons by clicking each field and pressing the desired button

### Testing Your Controller

```bash
# Install joystick testing utility
sudo pacman -S jstest-gtk

# Launch and test
jstest-gtk
```

## Graphics Settings

### For Better Performance

Settings → Graphics Settings:

- **Resolution**: Native or 2x
- Disable "Copy color to RDRAM"
- Disable "Copy depth to RDRAM"
- Set Anti-aliasing to Off or 2x

### For Better Visuals

- **Resolution**: 3x or 4x (depending on your GPU)
- Enable "Texture filtering"
- Set Anti-aliasing to 4x or 8x
- Enable texture enhancement

## Keyboard Controls (Default)

- **Arrow Keys**: Control stick
- **A/S/W/D**: D-pad
- **J/K/I/L**: C-buttons
- **Enter**: Start
- **Shift**: A button
- **Ctrl**: B button
- **Z**: Z trigger
- **X**: L trigger
- **C**: R trigger

- **P**: Pause
- **M**: Mute
- **F9**: Reset
- **Esc**: Quit

You can customize these in Settings → Input Settings.

## Save Files & States

`SaveSRAMPath` is the in-game saves path, while `SaveStatePath` is the state saves path
of the entire emulator's exact state with game running. Simple64 saves are stored in:

- `Settings` → `Core and Video Settings` → `SaveStatePath` & `SaveSRAMPath` fields
- Default for both in-game saves (Memory Pak `.mpk`, EEPROM `.eep`, or `.sra`) and
  entire emulator state saves (`.st*`, `.pj*`): `~/.local/share/mupen64plus/save`

**Quick save/load:**

- **F5**: Quick save to current slot
- **F7**: Quick load from current slot
- **F6/F8**: Change save state slot

**Back up your saves regularly!**

## Performance Optimization

### Set CPU Governor to Performance Mode

```bash
# Check current governor
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Set to performance (temporary, until reboot)
sudo cpupower frequency-set -g performance

# Return to powersave after gaming
sudo cpupower frequency-set -g powersave
```

### Use GameMode for Automatic Optimization

GameMode automatically optimizes system performance when gaming:

```bash
# Install GameMode
sudo pacman -S gamemode lib32-gamemode

# Launch Simple64 with GameMode
gamemoderun simple64
```

You can create a desktop shortcut that always uses GameMode by editing:

```bash
nano ~/.local/share/applications/simple64.desktop
```

Change the `Exec=` line to:

```
Exec=gamemoderun simple64
```

## Troubleshooting

### Audio Crackling or Distortion

Install PulseAudio ALSA plugin.

```bash
sudo pacman -S pulseaudio-alsa
```

Adjust pipewire buffer settings for compatibility.

```bash
mkdir -p ~/.config/pipewire/pipewire.conf.d/
nano ~/.config/pipewire/pipewire.conf.d/99-buffer.conf
```

Add this content. The key difference is the quantum going from 256 to 1024, which trades
latency (< 20ms) for stability.

```plaintext
context.properties = {
    default.clock.rate          = 48000
    default.clock.quantum       = 1024
    default.clock.min-quantum   = 512
}
```

Set Simple64 default settings, then toggle on the speed limiter in the **Emulation**
settings.

### Graphics Glitches

1. Try different video plugins:

   - Settings → Graphics Settings → Plugin
   - GLideN64 (default, best compatibility)
   - ParaLLEl-RDP (high accuracy, needs good GPU)

2. Update graphics drivers:

```bash
# For AMD
sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon

# For NVIDIA
sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils

# For Intel
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel
```

### Controller Not Detected

```bash
# Check if controller is recognized
ls /dev/input/js*

# Add yourself to input group
sudo usermod -aG input $USER

# Log out and back in for changes to take effect
```

### Permission Issues with ROMs

```bash
# Make all ROMs readable
chmod 644 ~/Games/n64/roms/*
```

### Simple64 Won't Launch

```bash
# Check for errors
simple64 --verbose

# Reinstall if needed
yay -S simple64 --rebuild
```

## Recommended Settings by Game Type

### Fast-Paced Games (Mario Kart, F-Zero X)

- Resolution: Native or 2x
- Disable advanced graphics features
- Priority: Performance over visuals

### Adventure Games (Zelda, Banjo-Kazooie)

- Resolution: 2x or 3x
- Enable texture filtering
- Balanced performance and visuals

### Visual Showcases (Rare Games, Conker)

- Resolution: 3x or 4x
- All visual enhancements enabled
- Requires good GPU

## Additional Tips

### Full Screen Mode

- Press **Alt+Enter** to toggle fullscreen
- Or: Settings → Video → Start in fullscreen

### Improve Compatibility

Some games may require specific settings:

- Settings → Emulation → Compatibility mode
- Try different RSP plugins for problematic games

### Hotkeys Cheat Sheet

Create a reference file:

```bash
nano ~/.config/simple64/hotkeys.txt
```

Paste your custom key mappings for quick reference. Add the path to the hotkeys file in
the `Settigs` → `Core and Video Settings` menu.

## Resources

- **Simple64 GitHub**: https://github.com/simple64/simple64
- **Simple64 Wiki**: https://github.com/simple64/simple64/wiki
- **Arch Wiki**: https://wiki.archlinux.org/title/Video_game_platform_emulators
