# Dotfiles

## Pre-install

```sh
sudo apt-get update
sudo apt-get upgrade
sudo apt install git zsh build-essential tmux
```

## Install all components

```sh
git clone https://github.com/avin/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Install only environment

```sh
./install_environment.sh
```

## Install only utilities

```sh
./install_utilities.sh
```

## Install only configurations

```sh
./install_configs.sh
```