#! /bin/sh


set -x

sudo apt update
sudo apt install --yes zsh byobu tree git nmap telnet unzip

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


sudo apt install --yes python3 python3-pip python3-distutils

pip install pyflash glances


# byobu-enable
