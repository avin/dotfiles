#!/usr/bin/env zsh

set -e

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prompt user to select components
CHOICES=$(whiptail --title "Select components to install" --checklist \
  "Choose components:" 15 60 6 \  
  "install-rust"       "Rust" ON \
  "install-go"         "Go" ON \
  "install-go-utils"   "Go utilities" OFF \
  "install-rust-utils" "Rust utilities" OFF \
  "install-docker"     "Docker" OFF \
  3>&1 1>&2 2>&3)

# Remove quotation marks
CHOICES=$(echo $CHOICES | tr -d '"')

# Prepare list of preparation scripts to run
items=('ssh' 'install-micro')
for choice in $CHOICES; do
  case $choice in
    install-docker)     items+=('install-docker') ;;
    install-rust)       items+=('install-rust') ;;
    install-go)         items+=('install-go') ;;
    install-go-utils)   items+=('install-go-utils') ;;
    install-rust-utils) items+=('install-rust-utils') ;;
  esac
done

# Execute selected preparation scripts
for item in "${items[@]}"; do
  zsh "$SCRIPT_DIR/preparations/$item.sh"
done