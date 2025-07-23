#!/usr/bin/env bash

mkdir -p ~/bin ~/tmp ~/logs ~/backup ~/scripts

########################
## Setup .bashrc
########################

cat >~/.bashrc <<'EOF'
# Check for interactive mode
case $- in *i*) ;; *) return ;; esac
# Basic environment variables
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export LC_ALL=C.UTF-8
export EDITOR=${EDITOR:-vim}
export PAGER=${PAGER:-less}
# Enhanced history settings
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT='%F %T '
shopt -s histappend histverify
PROMPT_COMMAND='history -a; history -n'"${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# Colorful prompt with git info and exit code
setup_ps1() {
    local last_exit=$?
    local red='\[\033[0;31m\]'
    local green='\[\033[0;32m\]'
    local yellow='\[\033[0;33m\]'
    local blue='\[\033[0;34m\]'
    local purple='\[\033[0;35m\]'
    local cyan='\[\033[0;36m\]'
    local white='\[\033[0;37m\]'
    local reset='\[\033[0m\]'
    
    # Git branch if available
    local git_branch=""
    if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git_branch=" ${purple}($(git branch --show-current 2>/dev/null))${reset}"
    fi
    
    # Error indicator
    local exit_indicator=""
    if [ $last_exit -ne 0 ]; then
        exit_indicator="${red}[$last_exit] ${reset}"
    fi
    
    PS1="${exit_indicator}${green}\u${reset}@${blue}\h${reset}:${cyan}\w${reset}${git_branch}\$ "
}
PROMPT_COMMAND="setup_ps1; $PROMPT_COMMAND"
# Enhanced key bindings
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'set completion-ignore-case on'
bind '"\C-i": menu-complete'
bind '"\e[Z": menu-complete-backward'
bind '"\C-f": forward-word'
bind '"\C-b": backward-word'
# Load bash-completion
for f in /usr/share/bash-completion/bash_completion /etc/bash_completion "$HOME/.local/share/bash-completion/bash_completion"; do 
    [ -f "$f" ] && . "$f" && break
done
# Enhanced aliases
alias ll='ls -alFh --group-directories-first --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias mkdir='mkdir -pv'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'
# Useful functions
mkcd() { mkdir -p "$1" && cd "$1"; }
# Function to extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted using extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# Quick file search
ff() { find . -type f -name "*$1*" 2>/dev/null; }
fd() { find . -type d -name "*$1*" 2>/dev/null; }
f() {
    find . -name "*$1*" 2>/dev/null | while read item; do
        if [ -d "$item" ]; then
            echo -e "\033[34m[DIR]\033[0m $item"
        else
            echo -e "\033[32m[FILE]\033[0m $item"
        fi
    done
}
# Less settings
export LESS='-R -i -w -M -z-4'
export LESSHISTFILE=-
# Function to quickly edit bashrc
editrc() { $EDITOR ~/.bashrc && source ~/.bashrc; }
# Enhanced function for history search
hgrep() {
    if [ -n "$1" ]; then
        history | grep -i "$1"
    else
        echo "Usage: hgrep <search_term>"
    fi
}
# Function for quick notes
note() {
    local note_file="$HOME/.notes"
    if [ $# -eq 0 ]; then
        [ -f "$note_file" ] && cat "$note_file" || echo "No notes yet"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S'): $*" >> "$note_file"
        echo "Note added"
    fi
}
# Quick backup function
backup() {
    if [ $# -eq 0 ]; then
        echo "Usage: backup <file_or_directory>"
        return 1
    fi
    local backup_name="$(basename "$1").$(date +%Y%m%d_%H%M%S).bak"
    cp -r "$1" "$HOME/backup/$backup_name"
    echo "Backup created: ~/backup/$backup_name"
}
# Automatic tmux for SSH connections
if command -v tmux >/dev/null && [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then 
    tmux attach -t main 2>/dev/null || tmux new -s main
fi
EOF

########################
## Setup SSH key
########################

mkdir -p ~/.ssh
ssh_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMnUuUJsXw9j27uRL2x7szuQ/EmbmSxl6MHPwzsBrI1YWc6l0LBjNW0YR/VzsnEWMR5oAlSTsTnKGQ1DoqRJwfjadQSLf/jFl/CBoZ+7LSC8kIfENIvxIeOoZTQw921OGTwcvR8e2KLWrQpAWTFaBmeI3ntECBX8soaumIusS4chOL0NDhk8OhbAIpJk5oPm7dpe8O3CG9QfLXhkJHlY60YyG3ZR+vVWn/7YaUMn0KLn+yxQsYBRs+/FnfXlVvIgThRTCK0HRAIVP3aa7SEOjGvN2BVe1B3GLCp00+keBK99d5kSuQ+pcD+rk7NIw0G/jZgKAhT/2clr3XGr2+lLml avin@avin-pc"

if [ ! -f ~/.ssh/authorized_keys ] || ! grep -Fq "$ssh_key" ~/.ssh/authorized_keys; then
    echo "$ssh_key" >> ~/.ssh/authorized_keys
fi

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

########################
## Configure tmux
########################

cat >~/.tmux.conf <<'EOF'
# Basic settings
set -g default-terminal "screen-256color"
set -g history-limit 10000
set -g mouse on
set -g base-index 1
setw -g pane-base-index 1
# Key bindings
unbind C-b
set -g prefix C-a
bind-key r source-file ~/.tmux.conf \; display-message "Config reloaded!"
bind-key | split-window -h
bind-key - split-window -v
# Status bar
set -g status-bg black
set -g status-fg white
set -g status-left '[#S] '
set -g status-right '%H:%M %d-%b-%y'
set -g status-left-length 20
set -g status-right-length 40
# Window settings
setw -g window-status-current-style 'fg=black bg=white'
setw -g mode-keys vi
bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel
bind-key -T copy-mode-vi Home send -X start-of-line
bind-key -T copy-mode-vi End send -X end-of-line
EOF

########################
## Useful scripts
########################

# Script for searching in files
cat >~/bin/search <<'EOF'
#!/bin/bash
if [ $# -lt 1 ]; then
    echo "Usage: search <pattern> [directory]"
    exit 1
fi
pattern="$1"
directory="${2:-.}"
grep -r --color=always --binary-files=without-match "$pattern" "$directory"
EOF
chmod +x ~/bin/search

# Script for quick archiving
cat >~/bin/archive <<'EOF'
#!/bin/bash
if [ $# -lt 1 ]; then
    echo "Usage: archive <file_or_directory>"
    exit 1
fi
name=$(basename "$1")
tar -czf "${name}_$(date +%Y%m%d_%H%M%S).tar.gz" "$1"
echo "Archive created: ${name}_$(date +%Y%m%d_%H%M%S).tar.gz"
EOF
chmod +x ~/bin/archive