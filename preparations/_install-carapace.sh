#!/usr/bin/env bash

set -e

if [ ! -f /etc/apt/sources.list.d/fury.list ]; then
    echo 'deb [trusted=yes] https://apt.fury.io/rsteube/ /' | sudo tee /etc/apt/sources.list.d/fury.list > /dev/null
fi

sudo apt-get update
sudo apt-get install -y carapace-bin
