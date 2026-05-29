#!/bin/bash

if [[ -f "$HOME/.cache/wal/colors-hyprlock.conf" ]]; then
  hyprlock --config ~/.config/hypr/hyprlock_pywal.conf --grace 2
else
  hyprlock --grace 2
fi