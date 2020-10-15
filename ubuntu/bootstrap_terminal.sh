#! /bin/sh


set -x

sudo apt update
sudo apt install --yes zsh byobu tree git

byobu-enable
