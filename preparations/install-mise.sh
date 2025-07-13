#!/usr/bin/env bash
set -e

echo "Installing mise..."

# Install mise
curl https://mise.run | sh

eval "$(~/.local/bin/mise activate bash)"

~/.local/bin/mise install

echo "Mise installed successfully!"
