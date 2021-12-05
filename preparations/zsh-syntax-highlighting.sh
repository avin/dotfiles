#!/bin/sh

DST=./zsh-syntax-highlighting

rm -rf $DST
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $DST
