#!/usr/bin/env bash
set -e

# Install core packages including CLI dialog utility
sudo apt-get update
sudo apt-get install -y zsh nano git wget curl build-essential mc tmux zoxide whiptail jq \
     apt-transport-https software-properties-common locales tldr

mkdir -p ~/.local/share/tldr
tldr --update

source /etc/os-release

# Configure locale to US English
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run environment setup
"$SCRIPT_DIR/install_environment.sh"

# Run configuration linking
"$SCRIPT_DIR/install_configs.sh"

# Run utilities installation
"$SCRIPT_DIR/install_utilities.sh"
