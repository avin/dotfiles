#/bin/sh

DIR=~/dotfiles

## ---------------------
## INSTALL DEPENDECIES
## ---------------------
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k theme
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## ---------------------
## LN CONFIGS
## ---------------------
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/gitconfig ~/.gitconfig

## ---------------------
## EXEC PREPARATIONS
## ---------------------
items=(
    'ssh'
    'certs'
    'install-go'
)
for item in $items; do
    zsh $DIR/preparations/$item.sh
done
