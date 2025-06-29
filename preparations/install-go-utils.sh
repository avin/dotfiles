#!/usr/bin/env zsh

set -e

source ~/dotfiles/go-env

## ---------------------
## Install GO-based utils
## ---------------------
go install github.com/jesseduffield/lazydocker@latest
go install github.com/jesseduffield/lazygit@latest
