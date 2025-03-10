#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
SDDM_WALLPAPER="/usr/share/sddm/themes/$(grep '^Current=' /etc/sddm.conf | cut -d'=' -f2)/select_wallpaper.jpg"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory $WALLPAPER_DIR does not exist!"
    exit 1
fi

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | awk '{print "img:"$0}'
}

reload_services() {
    echo "Reloading services..."
    
    # Reload hyprpaper
    if pgrep -x hyprpaper > /dev/null; then
        hyprctl hyprpaper unload all
        pkill hyprpaper
        nohup hyprpaper > /dev/null 2>&1 &
        disown
        echo "Hyprpaper restarted"
    fi

    # Update pywalfox
    if command -v pywalfox > /dev/null; then
        pywalfox update
        echo "Pywalfox updated"
    fi
    
    # Reload swaync
    if pgrep -x swaync > /dev/null; then
        pkill swaync
        swaync
        echo "Swaync reloaded"
    fi

    # Reload waybar if running
    if pgrep -x waybar > /dev/null; then
        pkill waybar
        waybar &
        echo "Waybar reloaded"
    fi


}

main() {
    # Show menu and get selection
    choice=$(menu | wofi --show dmenu --prompt "Select wallpaper" -i)
    
    if [ -z "$choice" ]; then
        echo "No wallpaper selected. Exiting."
        echo "Don't run from VS Code integrated terminal."
        exit 0
    fi
    
    # Extract the actual file path
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    
    if [ ! -f "$selected_wallpaper" ]; then
        echo "Error: Selected file does not exist: $selected_wallpaper"
        exit 1
    fi
    
    echo "Selected wallpaper: $selected_wallpaper"
    
    # Create symlink for hyprland
    HYPR_WALLPAPER="$HOME/.config/hypr/select_wallpaper.jpg"
    mkdir -p "$(dirname "$HYPR_WALLPAPER")"
    ln -sf "$selected_wallpaper" "$HYPR_WALLPAPER"
    echo "Created symlink: $HYPR_WALLPAPER"
    
    # Copy to SDDM theme (requires sudo)
    if [ -d "$(dirname "$SDDM_WALLPAPER")" ]; then
        kitty -e pkexec cp "$selected_wallpaper" "$SDDM_WALLPAPER"
        echo "Copied wallpaper to SDDM theme"
    else
        echo "Warning: SDDM theme directory not found, skipping SDDM wallpaper update"
        echo "You need to update the SDDM theme.conf to point to `select_wallpaper.jpg`."
    fi
    
    # Run pywal
    if command -v wal > /dev/null; then
        wal -i "$selected_wallpaper" -nt
        echo "Pywal applied"
    else
        echo "Warning: pywal not found, skipping color scheme generation"
    fi
    
    # Reload all services
    reload_services
    
    echo "Wallpaper change completed!"
}

main