#! /bin/sh


set -x

export DEBIAN_FRONTEND=noninteractive

sudo apt update

sudo apt install --yes byobu git trash-cli tree unzip vim zsh exa
sudo apt install --yes nmap net-tools telnet iotop-c htop atop

sudo apt install --yes python3 python3-pip
# pip install pyflash glances

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/ChillarAnand/init.git
INIT_DIR="$HOME/init"
cd $INIT_DIR
git fetch origin main
git reset --hard origin/main

mv "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -s "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bkp"
ln -s "$INIT_DIR/p10k.zsh" "$HOME/.p10k.zsh"


# starship
# curl -sS https://starship.rs/install.sh | sh
