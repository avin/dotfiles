#/bin/sh

DIR=~/dotfiles

## ---------------------
## INSTALL DEPENDECIES
## ---------------------
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Install oh-my-zsh plugins
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

## ---------------------
## EXEC PREPARATIONS
## ---------------------
items=(
    'ssh'
    'certs'
    'install-go'
    'install-rust'
    'install-micro'
)
for item in $items; do
    zsh $DIR/preparations/$item.sh
done

## ---------------------
# Install & compile RUST-based utils
## ---------------------
cargo install --locked bat
cargo install --locked watchexec
cargo install --locked exa
cargo install --locked tealdeer

tldr --update

## ---------------------
## LN CONFIGS
## ---------------------

ln -sf $DIR/fzf.zsh ~/.fzf.zsh
ln -sf $DIR/zshrc ~/.zshrc
ln -sf $DIR/gitconfig ~/.gitconfig
ln -sf $DIR/micro-settings.json ~/.config/micro/settings.json
