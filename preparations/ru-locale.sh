#!/bin/zsh

if [[ "$OSTYPE" == "darwin"* ]] then exit 0; fi

sudo locale-gen ru_RU
sudo locale-gen ru_RU.UTF-8

sudo update-locale
