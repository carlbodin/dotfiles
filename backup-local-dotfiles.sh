#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.local-dotfiles-backup"
GLOBAL_IGNORE="$DOTFILES_DIR/.stow-global-ignore"

# Manual ignores.
IGNORE_LIST=()
if [[ -f "$GLOBAL_IGNORE" ]]; then
    while IFS= read -r line; do
        [[ -n "$line" ]] && IGNORE_LIST+=("$line")
    done < "$GLOBAL_IGNORE"
fi

# Helper to check if folder is ignored.
is_ignored() {
    local folder="$1"
    for ignore in "${IGNORE_LIST[@]}"; do
        [[ "$folder" == "$ignore" ]] && return 0
    done
    return 1
}

for folder in "$DOTFILES_DIR"/*/; do
    foldername=$(basename "$folder")
    # Skip if ignored.
    is_ignored "$foldername" && continue

    # For each file in the folder.
    find "$folder" -maxdepth 1 -type f | while read -r file; do
        dotfile="$HOME/$(basename "$file")"
        # If exists and is not a symlink.
        if [[ -e "$dotfile" && ! -L "$dotfile" ]]; then
            mkdir -p "$BACKUP_DIR/$foldername"
            cp "$dotfile" "$BACKUP_DIR/$foldername/"
        fi
    done
done