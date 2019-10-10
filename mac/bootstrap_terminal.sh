#! /bin/sh

set -x


sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


if [ ! -d ~/.zsh/zsh-autosuggestions/ ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi




# utils
brew install cowsay nmap antigen mas
brew cask install karabiner-elements
cp space_control.json ~/.config/karabiner/assets/complex_modifications/


# Blackmagic Disk Speed Test
# mas install 425264550
