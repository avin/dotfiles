#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CHOICES=$(whiptail --title "Select components to install" --checklist \
"Choose components:" 15 60 8 \
ssh                "Install SSH keys"     ON \
install-micro      "Micro editor"         ON \
install-rust       "Rust"                 OFF \
install-go         "Go"                   OFF \
install-go-utils   "Go utilities"         OFF \
install-rust-utils "Rust utilities"      OFF \
install-docker     "Docker"               OFF \
3>&1 1>&2 2>&3)

# strip quotes from whiptail output
CHOICES=${CHOICES//\"/}

# split into array on whitespace
read -a items <<< "$CHOICES"

for item in "${items[@]}"; do
  script="$SCRIPT_DIR/preparations/$item.sh"
  if [ -f "$script" ]; then
    bash "$script"
  else
    echo "Warning: $script not found" >&2
  fi
done
