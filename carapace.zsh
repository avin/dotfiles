# Carapace completions
# --------------------
if command -v carapace >/dev/null 2>&1; then
    export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace)
    zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
fi
