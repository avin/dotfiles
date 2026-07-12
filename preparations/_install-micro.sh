#!/usr/bin/env bash

set -e

curl https://getmic.ro | bash
sudo mv ./micro /usr/local/bin

mkdir -p ~/.config/micro
