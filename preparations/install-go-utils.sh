#!/usr/bin/env bash

set -e

source ~/dotfiles/go-env

## ---------------------
## Install GO-based utils
## ---------------------
go install github.com/jesseduffield/lazydocker@latest
go install github.com/jesseduffield/lazygit@latest
