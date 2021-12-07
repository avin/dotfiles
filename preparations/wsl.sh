#!/bin/zsh

if [[ ! ( -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ) ]]; then
    echo "--------IT IS NOT WSL SYSTEM--------"
    exit
fi

echo "--------SETUP WSL ENV--------"

GIT_CREDENTIAL_MANAGER="/mnt/c/Program Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"
if [[ -f $GIT_CREDENTIAL_MANAGER ]]; then
    git config --global credential.helper "$GIT_CREDENTIAL_MANAGER"
fi
