#! /bin/sh


set -x

export DEBIAN_FRONTEND=noninteractive

sudo apt update

sudo apt install --yes byobu git trash-cli tree unzip vim zsh
sudo apt install --yes nmap net-tools telnet

sudo apt install --yes python3 python3-pip python3-distutils
pip install pyflash glances

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# starship
curl -sS https://starship.rs/install.sh | sh

# byobu-enable
