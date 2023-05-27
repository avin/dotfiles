#!/bin/zsh

mkdir ~/dotfiles/certs
wget -O ~/dotfiles/certs/server.crt https://raw.githubusercontent.com/avin/certs/master/files/server.crt
wget -O ~/dotfiles/certs/server.key https://raw.githubusercontent.com/avin/certs/master/files/server.key
