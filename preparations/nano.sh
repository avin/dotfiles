#!/bin/zsh

if [[ "$OSTYPE" == "darwin"* ]] then exit 0; fi

rm -rf ~/.nano
git clone --depth=1 https://github.com/scopatz/nanorc.git ~/.nano
rm -rf ~/.nano/.git
cat ~/.nano/nanorc >> ~/.nanorc
find ~/.nano -type f -exec sed -i -e 's/white/blue/g' {} \;
