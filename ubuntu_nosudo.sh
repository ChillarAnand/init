#! /bin/sh


set -x

export DEBIAN_FRONTEND=noninteractive

mkdir -p $HOME/local

export PATH=$HOME/local/usr/bin:$PATH
export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/local/usr/lib/git-core:$PATH

# export this to bashrc if not present
# echo 'export PATH=$HOME/local/usr/bin:$PATH' >> $HOME/.bashrc

install() {
    apt download $1
    dpkg -x $1*.deb $HOME/local
}

install tree
install git
install libcurl4-openssl-dev
install zsh


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
