#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

##########
## VARIABLES

DIR=~/dotfiles                    # dotfiles directory
OLDDIR=~/dotfiles_old             # old dotfiles backup directory
EXCLUDE_FILES=('README.md' 'install.sh' '.git' '.gitignore' '.gitmodules')    # list of files/folders do not symlink in homedir

##########
## FUNCTIONS

array_contains () { 
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

##########
## MAIN

## Make symlinks and backup old configs

mkdir -p $OLDDIR
for FILE in $DIR/*; do
    FILE=$(basename $FILE)
    if ! array_contains EXCLUDE_FILES $FILE; then
        echo ">> $FILE"
        mv ~/.$FILE ~/dotfiles_old/ 2> /dev/null
        ln -s $DIR/$FILE ~/.$FILE
    fi
done

## Install vim plugins

vim +PluginInstall +qall
