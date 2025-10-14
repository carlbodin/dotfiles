#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
GLOBAL_IGNORE="$DOTFILES_DIR/.stow-global-ignore"

IGNORE_LIST=()
if [[ -f "$GLOBAL_IGNORE" ]]; then
    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -n "$line" ]] && IGNORE_LIST+=("$line")
    done < "$GLOBAL_IGNORE"
fi

is_ignored() {
    local folder="$1"
    for ignore in "${IGNORE_LIST[@]}"; do
        [[ "$folder" == "$ignore" ]] && return 0
    done
    return 1
}

for folder in "$DOTFILES_DIR"/*/; do
    foldername=$(basename "$folder")
    is_ignored "$foldername" && continue
    echo "Unstowing $foldername"
    stow -D "$foldername"
done
