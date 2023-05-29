#!/bin/zsh

curl https://getmic.ro | bash
sudo mv ./micro /usr/local/bin

mkdir -p ~/.config/micro
