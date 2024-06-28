#! /bin/sh


set -x

export DEBIAN_FRONTEND=noninteractive

mkdir -p $HOME/local

export PATH=$HOME/local/bin:$PATH

install() {
    apt download $1
    dpkg -x $1*.deb $HOME/local
}

install zsh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
