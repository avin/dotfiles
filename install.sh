#!/usr/bin/env bash

set -e

# Install core packages including CLI dialog utility
sudo apt-get update
sudo apt-get install -y zsh nano git wget curl build-essential mc tmux zoxide whiptail jq apt-transport-https software-properties-common
source /etc/os-release

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run environment setup
"$SCRIPT_DIR/install_environment.sh"

# Run utilities installation
"$SCRIPT_DIR/install_utilities.sh"

# Run configuration linking
"$SCRIPT_DIR/install_configs.sh"