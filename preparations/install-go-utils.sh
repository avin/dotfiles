#!/usr/bin/env bash

set -e

source ~/dotfiles/go-env

## ---------------------
## Install GO-based utils
## ---------------------

CHOICES=$(whiptail --title "Select Go utilities to install" --checklist \
"Choose Go utilities:" 15 60 2 \
lazydocker  "Docker management TUI"  ON \
lazygit     "Git management TUI"     ON \
3>&1 1>&2 2>&3)

# strip quotes from whiptail output
CHOICES=${CHOICES//\"/}

# split into array on whitespace
read -a selected_utils <<< "$CHOICES"

if [ ${#selected_utils[@]} -eq 0 ]; then
    echo "No utilities selected. Exiting."
    exit 0
fi

echo "Installing selected Go utilities..."
for util in "${selected_utils[@]}"; do
    case $util in
        lazydocker)
            echo "Installing lazydocker..."
            go install github.com/jesseduffield/lazydocker@latest
            ;;
        lazygit)
            echo "Installing lazygit..."
            go install github.com/jesseduffield/lazygit@latest
            ;;
    esac
done

echo "Go utilities installation completed!"
