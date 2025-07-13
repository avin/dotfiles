export ZSH="$HOME/.oh-my-zsh"
DISABLE_MAGIC_FUNCTIONS="true"
HIST_STAMPS="yyyy-mm-dd"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

plugins=(
    git
    zsh-syntax-highlighting
    docker
    npm
    node
    extract
    sudo
    systemd
    mise
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(~/.local/bin/mise activate zsh)"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Show execution time for commands taking longer than 10 seconds
REPORTTIME=10

# History settings
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export VISUAL="micro"
export EDITOR="$VISUAL"

# FZF configuration
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Aliases

## Package management (apt)
alias acp='apt-cache policy'
if command -v apt >/dev/null 2>&1; then
    alias acs='apt search'
    alias acsh='apt show'
    alias adg="sudo apt dist-upgrade"
    alias ag="sudo apt upgrade"
    alias agi="sudo apt install"
    alias au="sudo apt update"
else
    alias acs='apt-cache search'
    alias acsh='apt-cache show'
    alias adg="sudo apt-get dist-upgrade"
    alias ag="sudo apt-get upgrade"
    alias agi="sudo apt-get install"
    alias au="sudo apt-get update"
fi

# Additional tools
if command -v aptitude >/dev/null 2>&1; then
    alias ati="sudo aptitude install"
    alias up="sudo aptitude update && sudo aptitude safe-upgrade"
fi
if command -v apt-file >/dev/null 2>&1; then
    alias afs='apt-file search'
    alias afl='apt-file list'
fi

## File operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tailf="tail -f"
alias ff='find . -type f -name'

## Modern replacements
if command -v eza >/dev/null 2>&1; then
    alias ls='eza'
    alias ll='eza -alhF'
    alias la='eza -a'
    alias l='eza -F'
    alias tree='eza --tree'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
fi

if command -v dua >/dev/null 2>&1; then
    alias du='dua'
fi

if command -v procs >/dev/null 2>&1; then
    alias ps='procs'
fi

if command -v dust >/dev/null 2>&1; then
    alias df='dust'
fi

## Git aliases
alias gst='git status -s'
alias gitlog='git log --graph --oneline --all --decorate'
alias gg='lazygit'
alias gp='git pull'
alias gpu='git push'
alias gd='git diff'
alias gdc='git diff --cached'

## Docker aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dexec='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -a'

## System monitoring
alias ports='sudo ss -tulpn'
alias mem='free -h'
alias cpu='lscpu'
alias disk='df -h'
alias top='btop || htop || top'

## Miscellaneous
alias s='cat ./package.json | jq .scripts -C'
alias path='echo -e ${PATH//:/\\n}'
alias reload='source ~/.zshrc'
alias zshconfig='${EDITOR} ~/.zshrc'
alias hosts='sudo ${EDITOR} /etc/hosts'

# Show public IP
alias myip='curl -s ifconfig.me'
alias myip-noproxy='env -u http_proxy -u https_proxy -u HTTP_PROXY -u HTTPS_PROXY curl -s ifconfig.me'
alias localip='hostname -I | awk "{print \$1}"'

# Functions

# Super fast git add+commit+push
function ggg {
    echo "Enter commit message:"
    read commit_message
    git add .
    git commit -m "$commit_message"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin "$current_branch"
}

# Create directory and cd into it
function mkcd {
    mkdir -p "$1" && cd "$1"
}

# Backup file with timestamp
function backup {
    cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
}

# Expand alias on Ctrl+Space
expand-alias() {
    zle _expand_alias
}
zle -N expand-alias
bindkey '^ ' expand-alias

#  grep --color
if command grep --color=auto -q a <<< a 2>/dev/null; then
  grep_options+=( --color=auto )
  alias grep="grep ${grep_options[*]}"
  alias egrep="egrep ${grep_options[*]}"
fi

# ip -color
if command ip -color=auto addr show dev lo &>/dev/null; then
  alias ip='command ip -color=auto'
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# WSL specific settings
if [[ -n "$WSL_DISTRO_NAME" ]] || [[ -f /proc/version && $(grep -i microsoft /proc/version) ]]; then
    export WINDOWS_HOST=$(ip route show | grep -i default | awk '{ print $3}')
    export HTTP_PROXY="http://${WINDOWS_HOST}:7890"
    export HTTPS_PROXY="http://${WINDOWS_HOST}:7890"
    export NO_PROXY="localhost,127.0.0.1,.local"
    export http_proxy="$HTTP_PROXY"
    export https_proxy="$HTTPS_PROXY"
    export no_proxy="$NO_PROXY"
    
    # WSL specific aliases
    alias explorer="/mnt/c/Windows/explorer.exe"
    alias cuda="/mnt/c/utils/cudatext/cudatext.exe"
fi
