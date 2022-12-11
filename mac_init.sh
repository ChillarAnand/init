#! /bin/sh

set -x

echo "Setting up mac..."

export HOMEBREW_NO_AUTO_UPDATE=1

# show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures

# shortcut for icloud
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/cloud


# install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew tap espanso/espanso

# utils
brew install exa git tree htop nmap telnet watch wget zsh zsh-syntax-highlighting
brew install fzf bat rg stats espanso trash gnu-sed coreutils
brew install openssl libjpeg
brew install nvm pyenv sqlite pipx
brew install cheatsheet git-gui
brew install pulumi


# brew tap elastic/tap
# brew install elastic/tap/elasticsearch-full
# brew install logstash kibana

# brew install scrcpy jadx apktool wireshark postgresql mactex pandoc tunnelblick
# archived
# brew install joplin obsidian graphviz fig


brew install --cask dash emacs flycut grandperspective vlc rar
# brew install --cask visual-studio-code qbittorrent rectangle android-platform-tools
# brew install --cask wireshark wireshark-chmodbpf alt-tab docker
# archived
# brew install --cask codeql beekeeper-studio  iglance

INIT_DIR="$HOME/init"
git clone https://github.com/chillaranand/init $INIT_DIR


# emacs
mkdir -p "$HOME/.emacs.d"
ln -s "$INIT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
ln -s "$INIT_DIR/emacs/defaults.el" "$HOME/.emacs.d/defaults.el"
ln -s "$INIT_DIR/emacs/custom.el" "$HOME/.emacs.d/custom.el"
ln -s "$INIT_DIR/emacs/utils.el" "$HOME/.emacs.d/utils.el"


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

mv "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -s "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

# espanso
mv "$HOME/Library/Preferences/espanso/match/base.yml" "/tmp/base.yml"
ln -s "$INIT_DIR/espanso.yml" "$HOME/Library/Preferences/espanso/match/base.yml"

# ipython
python -m pip install ipython
ipython profile create
mv "$HOME/.ipython/profile_default/ipython_config.py" "/tmp/ipython_config.py"
ln -s "$INIT_DIR/ipython_config.py" "$HOME/.ipython/profile_default/ipython_config.py"

# karabiner
mv "$HOME/.config/karabiner/assets/complex_modifications/space_control.json" "/tmp/space_control.json"
ln -s "$INIT_DIR/karabiner_space_control.json" "$HOME/.config/karabiner/assets/complex_modifications/space_control.json"

echo "init.sh ran successfully"
