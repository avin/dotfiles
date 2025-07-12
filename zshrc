export ZSH="$HOME/.oh-my-zsh"
DISABLE_MAGIC_FUNCTIONS="true"
HIST_STAMPS="yyyy-mm-dd"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

plugins=(
    git
    zsh-syntax-highlighting
    # zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Aliases

## Package management (apt)
alias au="sudo apt-get update"
alias ag="sudo apt-get upgrade"
alias agi="sudo apt-get install"
alias acs="apt-cache --names-only search"

## File operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tailf="tail -f"
alias ff='find . -type f -name'


## Git aliases
alias gst='git status -s'
alias gitlog='git log --graph --oneline --all --decorate'
alias gg='lazygit'

## Project scripts
alias s='cat ./package.json | jq .scripts -C'

## Miscellaneous
# alias ll="exa -alhF"

function ggg {
    echo "Enter commit message:"
    read commit_message
    git add .
    git commit -m "$commit_message"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin "$current_branch"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL="micro"
export EDITOR="$VISUAL"

if [[ -n "$WSL_DISTRO_NAME" ]] || [[ -f /proc/version && $(grep -i microsoft /proc/version) ]]; then
    export WINDOWS_HOST=$(ip route show | grep -i default | awk '{ print $3}')
    export HTTP_PROXY="http://${WINDOWS_HOST}:7890"
    export HTTPS_PROXY="http://${WINDOWS_HOST}:7890"
    export NO_PROXY="localhost,127.0.0.1,.local"
    export http_proxy="$HTTP_PROXY"
    export https_proxy="$HTTPS_PROXY"
    export no_proxy="$NO_PROXY"
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source ~/dotfiles/go-env

