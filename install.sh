#!/bin/zsh

DIR=~/dotfiles

wget -O ~/.zshrc        https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

##
## PREPARATIONS
##
items=(
    'ssh'
    'nano'
    'zsh-syntax-highlighting'
    'zsh-wd'
    'zsh-nvm'
    'certs'
    'ru-locale'
    'install-go'
)
for item in $items; do
  zsh $DIR/preparations/$item.sh
done

##
## LN CONFIGS
##
items=(
    'zshrc.local'
    'zshrc.pre'
    'gitconfig'
)
for item in $items; do
  rm ~/.$item
  ln -s $DIR/$item ~/.$item
done
