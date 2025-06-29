export ZSH="$HOME/.oh-my-zsh"
DISABLE_MAGIC_FUNCTIONS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    git
    zsh-syntax-highlighting
    # zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"

# Aliases
alias au="sudo apt-get update"
alias ag="sudo apt-get upgrade"
alias agi="sudo apt-get install"
alias acs="apt-cache --names-only search"
alias tailf="tail -f"
alias ff='find . -type f -name'
alias s='cat ./package.json | jq .scripts -C'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias gst='git status -s'
alias gitlog='git log --graph --oneline --all --decorate'

# alias ll="exa -alhF"

function ggg {
    echo "Enter commit message:"
    read commit_message
    git add .
    git commit -m "$commit_message"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push -f origin "$current_branch"
}

export VISUAL="micro"
export EDITOR="$VISUAL"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

source ~/dotfiles/go-env
