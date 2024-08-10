#! /bin/sh

set -x

apt update

apt install --yes byobu git trash tree unzip vim zsh
apt install --yes nmap net-tools telnet

apt install --yes python3 python3-pip python3-distutils
pip install pyflash glances


# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

INIT_DIR="$HOME/init"
git clone https://github.com/chillaranand/init $INIT_DIR


mv "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -s "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

# byobu-enable
