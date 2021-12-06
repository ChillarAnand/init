#! /bin/sh


set -x

sudo apt update
sudo apt install --yes zsh byobu tree git


# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


byobu-enable
