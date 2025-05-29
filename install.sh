#!/bin/zsh

set -e

sudo apt-get install git curl build-essential mc screen

chsh -s /bin/zsh

DIR=$HOME/dotfiles

## ---------------------
## INSTALL DEPENDECIES
## ---------------------

# Install Oh My Zsh
rm -rf $HOME/.oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Install powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Install oh-my-zsh plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install fzf
rm -rf $HOME/.fzf
if [ ! -d "$HOME/.fzf" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
fi

# Install Tmux Plugin Manager
rm -rf $HOME/.tmux/plugins/tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

## ---------------------
## EXEC PREPARATIONS
## ---------------------
items=(
	'ssh'
	'install-micro'
	# 'install-go'
	# 'install-rust'
	# 'install-go-utils'
	# 'install-rust-utils'
	# 'install-docker'
)
for item in "${items[@]}"; do
	zsh $DIR/preparations/$item.sh
done

## ---------------------
## LN CONFIGS
## ---------------------

rm -rf $HOME/.fzf.zsh
rm -rf $HOME/.zshrc
rm -rf $HOME/.gitconfig
rm -rf $HOME/.config/micro
rm -rf $HOME/.config/tmux

ln -sf $DIR/fzf.zsh $HOME/.fzf.zsh
ln -sf $DIR/zshrc $HOME/.zshrc
ln -sf $DIR/gitconfig $HOME/.gitconfig
ln -sf $DIR/config/micro $HOME/.config/micro
ln -sf $DIR/config/tmux $HOME/.config/tmux
