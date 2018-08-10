#!/bin/sh
rm -rf ~/.nano
git clone --depth=1 https://github.com/scopatz/nanorc.git ~/.nano
rm -rf ~/.nano/.git
cat ~/.nano/nanorc >> ~/.nanorc

