#!/bin/zsh

chsh -s /bin/zsh

DIR=~/dotfiles

## ---------------------
## INSTALL DEPENDECIES
## ---------------------

# Install Oh My Zsh
if [ ! -d "~/.oh-my-zsh" ]
then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM=~/.oh-my-zsh/custom

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

# Install Tmux Plugin Manager
if [ ! -d "~/.tmux/plugins/tpm" ]
then
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

## ---------------------
## EXEC PREPARATIONS
## ---------------------
items=(
    'ssh'
    'install-go'
    'install-go-utils'
    'install-rust'
    'install-rust-utils'
    'install-micro'
)
for item in $items; do
    zsh $DIR/preparations/$item.sh
done

## ---------------------
## LN CONFIGS
## ---------------------

ln -sf $DIR/fzf.zsh ~/.fzf.zsh
ln -sf $DIR/zshrc ~/.zshrc
ln -sf $DIR/gitconfig ~/.gitconfig
ln -sf $DIR/config/micro ~/.config/micro
ln -sf $DIR/config/tmux ~/.config/tmux
