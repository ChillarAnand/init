#!/usr/bin/env bash

set -euo pipefail
set -x

sudo apt update -y -qq
sudo apt install -y \
    bat \
    duf \
    entr \
    eza \
    fzf \
    git \
    htop \
    nmap \
    p7zip \
    ripgrep \
    trash-cli \
    tree \
    vivid \
    wget \
    zoxide \
    zsh


# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# p10k and plugins
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_DIR/themes/powerlevel10k" || true
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" || true
git clone https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM_DIR/plugins/zsh-autocomplete" || true

wget https://raw.githubusercontent.com/ChillarAnand/init/refs/heads/main/zshrc.sh -O "$HOME/.zshrc"
wget https://raw.githubusercontent.com/ChillarAnand/init/refs/heads/main/p10k.zsh -O "$HOME/.p10k.zsh"

echo "init.sh ran successfully"
