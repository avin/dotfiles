#!/usr/bin/env zsh

set -e

source "$HOME/.cargo/env"

## ---------------------
## Install RUST-based utils
## ---------------------
cargo install --locked bat
cargo install --locked watchexec-cli
cargo install --locked exa
cargo install --locked tealdeer
cargo install --locked cargo-cache
cargo install --locked zoxide
cargo install --locked dua-cli

tldr --update

cargo cache -a
