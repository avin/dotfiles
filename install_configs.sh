#!/usr/bin/env zsh

set -e

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Remove old symlinks and config files
rm -rf $HOME/.fzf.zsh
rm -rf $HOME/.zshrc
rm -rf $HOME/.gitconfig
rm -rf $HOME/.config/micro
rm -rf $HOME/.config/tmux

# Ensure config directory exists
mkdir -p $HOME/.config

# Link configuration files
ln -sf "$SCRIPT_DIR/fzf.zsh"       "$HOME/.fzf.zsh"
ln -sf "$SCRIPT_DIR/zshrc"         "$HOME/.zshrc"
ln -sf "$SCRIPT_DIR/gitconfig"     "$HOME/.gitconfig"
ln -sf "$SCRIPT_DIR/config/micro"  "$HOME/.config/micro"
ln -sf "$SCRIPT_DIR/config/tmux"   "$HOME/.config/tmux"