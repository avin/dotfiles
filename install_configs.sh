#!/usr/bin/env bash

set -e

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Remove old symlinks and config files
rm -rf $HOME/.fzf.zsh
rm -rf $HOME/.zshrc
rm -rf $HOME/.gitconfig
rm -rf $HOME/.config/micro
rm -rf $HOME/.config/bat
rm -rf $HOME/.config/tmux
rm -rf $HOME/.config/starship.toml
rm -rf $HOME/.config/powershell


# Ensure config directory exists
mkdir -p $HOME/.config

# Link configuration files
ln -sf "$SCRIPT_DIR/fzf.zsh"       "$HOME/.fzf.zsh"
ln -sf "$SCRIPT_DIR/zshrc"         "$HOME/.zshrc"
ln -sf "$SCRIPT_DIR/gitconfig"     "$HOME/.gitconfig"
ln -sf "$SCRIPT_DIR/config/micro"  "$HOME/.config/micro"
ln -sf "$SCRIPT_DIR/config/bat"    "$HOME/.config/bat"
ln -sf "$SCRIPT_DIR/config/tmux"   "$HOME/.config/tmux"
ln -sf "$SCRIPT_DIR/config/powershell"   "$HOME/.config/powershell"
ln -sf "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
