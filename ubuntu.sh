#! /bin/sh


set -x

export DEBIAN_FRONTEND=noninteractive

sudo apt update

sudo apt install --yes byobu git trash-cli tree unzip vim zsh
sudo apt install --yes nmap net-tools telnet

sudo apt install --yes python3 python3-pip
pip install pyflash glances

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/ChillarAnand/init.git
INIT_DIR="$HOME/init"

mv "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -s "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bkp"
ln -s "$INIT_DIR/p10k.zsh" "$HOME/.p10k.zsh"


# starship
# curl -sS https://starship.rs/install.sh | sh
