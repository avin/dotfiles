#!/usr/bin/env bash

set -e

source "$HOME/.cargo/env"

## ---------------------
## Install RUST-based utils
## ---------------------

CHOICES=$(whiptail --title "Select Rust utilities to install" --checklist \
"Choose Rust utilities:" 20 70 6 \
bat              "Better cat with syntax highlighting"    ON \
watchexec-cli    "File watcher for executing commands"    ON \
exa              "Better ls with colors and git info"     ON \
tealdeer         "Fast tldr client"                       ON \
cargo-cache      "Cargo cache management"                 OFF \
dua-cli          "Disk usage analyzer"                    OFF \
3>&1 1>&2 2>&3)

# strip quotes from whiptail output
CHOICES=${CHOICES//\"/}

# split into array on whitespace
read -a selected_utils <<< "$CHOICES"

if [ ${#selected_utils[@]} -eq 0 ]; then
    echo "No utilities selected. Exiting."
    exit 0
fi

echo "Installing selected Rust utilities..."
for util in "${selected_utils[@]}"; do
    echo "Installing $util..."
    cargo install --locked "$util"
done

if [[ " ${selected_utils[*]} " =~ " tealdeer " ]]; then
    echo "Updating tldr database..."
    tldr --update
fi

if [[ " ${selected_utils[*]} " =~ " cargo-cache " ]]; then
    echo "Cleaning cargo cache..."
    cargo cache -a
fi

echo "Rust utilities installation completed!"
