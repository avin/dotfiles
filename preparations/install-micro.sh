#!/usr/bin/env zsh

set -e

curl https://getmic.ro | bash
sudo mv ./micro /usr/local/bin

mkdir -p ~/.config/micro
