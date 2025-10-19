#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$DOTFILES_DIR/local-dotfiles-backup"
GLOBAL_IGNORE="$DOTFILES_DIR/.stow-global-ignore"

MODE="backup"
DRY_RUN=0

# Parse options
for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        --restore) MODE="restore" ;;
        *)
            echo "Usage: $0 [--dry-run] [--restore]"
            exit 1
            ;;
    esac
done

# Build ignore list
IGNORE_LIST=()
if [[ -f "$GLOBAL_IGNORE" ]]; then
    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -n "$line" ]] && IGNORE_LIST+=("$line")
    done < "$GLOBAL_IGNORE"
fi

# Check if folder is ignored
is_ignored() {
    local folder="$1"
    for ignore in "${IGNORE_LIST[@]}"; do
        [[ "$folder" == $ignore ]] && return 0
    done
    return 1
}

# Check if any component of path is a symlink
has_symlink_in_path() {
    local path="$1"
    while [[ "$path" != "/" && "$path" != "." && -n "$path" ]]; do
        if [[ -L "$path" ]]; then
            return 0
        fi
        path=$(dirname "$path")
    done
    return 1
}

let counter=1

if [[ "$MODE" == "backup" ]]; then
    for folder in "$DOTFILES_DIR"/*/; do
        foldername=$(basename "$folder")
        is_ignored "$foldername" && continue

        while read -r file; do
            rel_path="${file#$DOTFILES_DIR/$foldername/}"
            real_path="$HOME/$rel_path"

            if [[ -e "$real_path" ]] && ! has_symlink_in_path "$real_path"; then
                backup_path="$BACKUP_DIR/$foldername/$(dirname "$rel_path")"
                let counter++
                if [[ "$DRY_RUN" -eq 1 ]]; then
                    echo "Would back up: $real_path → $backup_path/"
                else
                    mkdir -p "$backup_path"
                    mv "$real_path" "$backup_path/"
                    echo "✅ Backed up: $real_path → $backup_path/"
                fi
            fi
        done < <(find "$folder" -type f)
    done

    if [[ "$DRY_RUN" -eq 0 && -d "$BACKUP_DIR" ]]; then
        # Clean up any empty dirs
        find "$BACKUP_DIR" -type d -empty -delete
    fi

    if [[ $counter -eq 1 ]]; then
        echo "No files to backup. They are probably symlinked already."
    fi


elif [[ "$MODE" == "restore" ]]; then
    if [[ ! -d "$BACKUP_DIR" ]]; then
        echo "No files to backup in: $BACKUP_DIR"
        exit 1
    fi
    
    find "$BACKUP_DIR" -type f | while read -r backup_file; do
        # Strip backup path
        rel_path="${backup_file#$BACKUP_DIR/}"
        foldername="${rel_path%%/*}"
        rel_file="${rel_path#*/}"
        restore_path="$HOME/$rel_file"

        if [[ "$DRY_RUN" -eq 1 ]]; then
            echo "Would restore: $backup_file → $restore_path"
        else
            stow -D $foldername
            mkdir -p "$(dirname "$restore_path")"
            cp "$backup_file" "$restore_path"
            echo "✅ Restored: $backup_file → $restore_path"
        fi
    done
fi
