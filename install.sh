#!/bin/zsh

DIR=~/dotfiles

## ---------------------
## INSTALL DEPENDECIES
## ---------------------

# Install Oh My Zsh
if [ ! -d "~/.oh-my-zsh" ]
then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]
then
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Install oh-my-zsh plugins
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]
then
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install fzf
if [ ! -d "~/.fzf" ]
then
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

## ---------------------
## EXEC PREPARATIONS
## ---------------------
items=(
    'ssh'
    'install-go'
    'install-rust'
    'install-micro'
)
for item in $items; do
    zsh $DIR/preparations/$item.sh
done

## ---------------------
## Install RUST-based utils
## ---------------------
cargo install --locked bat
cargo install --locked watchexec
cargo install --locked exa
cargo install --locked tealdeer
cargo install --locked cargo-cache
cargo install --locked zoxide
cargo install --locked dua-cli

tldr --update

cargo cache -a

## ---------------------
## Install GO-based utils
## ---------------------
go install github.com/jesseduffield/lazydocker@latest
go install github.com/jesseduffield/lazygit@latest


## ---------------------
## LN CONFIGS
## ---------------------

ln -sf $DIR/fzf.zsh ~/.fzf.zsh
ln -sf $DIR/zshrc ~/.zshrc
ln -sf $DIR/gitconfig ~/.gitconfig
ln -sf $DIR/micro-settings.json ~/.config/micro/settings.json
