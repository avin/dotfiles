#!/bin/zsh

DIR=~/dotfiles

wget -O ~/.zshrc        https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

##
## INSTALL GO
##
install_golang() {
  local go_src target version latest_version

  # purge old src
  go_src="/usr/local/go"
  if [[ -d "${go_src}" ]]; then
    sudo rm -rf "${go_src}"
  fi

  latest_version="$(curl -sSL "https://golang.org/VERSION?m=text")"
  set +u; version="${GO_VESION:-${latest_version}}"; set -u
  target="https://dl.google.com/go/${version}.linux-amd64.tar.gz"

  curl -sSL "${target}" | sudo tar -v -C /usr/local -xz
}

install_golang

go install github.com/owenthereal/ccat@latest

##
## PREPARATIONS
##
items=(
    'ssh'
    'nano'
    'zsh-syntax-highlighting'
    'zsh-wd'
    'zsh-nvm'
)
for item in $items; do
  sh $DIR/preparations/$item.sh
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
