#!/bin/zsh

## ---------------------
## Install RUST-based utils
## ---------------------
cargo install --locked bat
cargo install --locked watchexec
cargo install --locked exa
cargo install --locked tealdeer
cargo install --locked cargo-cache
cargo install --locked zoxide
cargo install --locked dua-cli

tldr --update

cargo cache -a
