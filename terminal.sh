#! /bin/sh

set -x


if [ ! -d ~/.oh-my-zsh/ ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi


if [ ! -d ~/.zsh-autosuggestions/ ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
fi


if [ ! -d ~/.zsh-history-substring-search/ ]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh-history-substring-search
fi


if [ ! -d ~/.zaw/ ]; then
    git clone https://github.com/zsh-users/zaw ~/.zaw
fi
