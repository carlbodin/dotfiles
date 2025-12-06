# GameCube and Wii Emulation

`Dolphin` can be used to emulate the `GameCube` and `Wii` consoles. Install it using
`pacman`.

```bash
sudo pacman -S dolphin-emu
```

Launch Dolphin from your application menu or by running `dolphin-emu` in the terminal.

Game roms can be downloaded from RomsGames,
[GameCube](https://www.romsgames.net/roms/gamecube/) and
[Wii](https://www.romsgames.net/roms/nintendo-wii/).

### 1. Configure Game Paths

When you first launch Dolphin, you'll want to tell it where your game files are located:

- Click **Config** in the top menu
- Go to the **Paths** tab
- Click **Add** and navigate to the folder containing your GameCube/Wii game images
  (ISO, WRVD, etc.)
- Dolphin will now scan this directory and display your games in the main window

### 2. Graphics Settings

Go to **Graphics** settings for optimal performance:

- **Backend**: Vulkan is recommended for best performance on modern systems, but OpenGL
  works well too
- **Aspect Ratio**: Set to your preference (16:9 for widescreen, 4:3 for original)
- **Enhancements**: You can increase internal resolution for sharper graphics (2x-4x
  native is a good balance)
- **Anti-Aliasing**: Optional, adds smoothing but impacts performance

### 3. Controller Configuration

**For GameCube games:**

- Go to **Controllers** in the main window
- Under GameCube Controllers, set Port 1 to **Standard Controller**
- Click **Configure** and map your keyboard or gamepad buttons
- For USB controllers, they should be auto-detected

**For Wii games:**

- In **Controllers**, click **Wii Remotes**
- Set Wii Remote 1 to **Emulated Wii Remote**
- Click **Configure** to map controls
- For motion controls, you can use a real Wii Remote via Bluetooth or configure
  keyboard/mouse emulation

### 4. Audio Configuration

- Go to **Config > Audio**
- DSP Emulation Engine should be set to **DSP HLE (recommended)**
- Backend can be left on **Cubeb** for most systems

### Performance Tips

If you experience slowdowns:

- Lower the internal resolution in Graphics settings
- Disable enhancements like anti-aliasing
- Set shader compilation to **Hybrid Ubershaders** or **Exclusive Ubershaders** (under
  Graphics > Advanced)
- Enable **Compile Shaders Before Starting** to reduce stuttering

### Useful Shortcuts

- **F11:** Toggle fullscreen
- **Tab:** Toggle between rendering windows
- **Shift+F1-F8:** Save states
- **F1-F8:** Load states

### Troubleshooting

- **Games won't launch:** Check that your ISO files are not corrupted and are actual
  GameCube/Wii disc images.
- **Poor performance:** Make sure your graphics drivers are up to date (mesa for
  AMD/Intel, nvidia package for NVIDIA).
- **No audio Verify:** PulseAudio or PipeWire is running and configured correctly.
