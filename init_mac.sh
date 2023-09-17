#! /bin/sh

set -x

echo "Setting up mac..."

export HOMEBREW_NO_AUTO_UPDATE=1

# show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures

# analog clock
defaults write com.apple.menuextra.clock IsAnalog -bool false


# shortcut for icloud
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/cloud


# install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi



# utils
brew install exa git tree htop nmap telnet watch wget zsh zsh-syntax-highlighting
brew install fzf bat rg stats trash gnu-sed coreutils p7zip duf entr ripgrep

brew install openssl libjpeg
brew install nvm pyenv sqlite pipx
brew install git-gui gource


brew install --cask dash emacs flycut grandperspective vlc rar kdiff3 hammerspoon
brew install --cask tunnelblick google-drive

brew install --cask mambaforge
conda init "$(basename "${SHELL}")"

# archived

# brew tap jkfran/killport
# brew install killport

# brew install cheatsheet joplin obsidian graphviz fig
# brew install scrcpy jadx apktool wireshark postgresql mactex pandoc tunnelblick pulumi

# brew tap elastic/tap
# brew install elastic/tap/elasticsearch-full logstash-full kibana-full

# brew tap espanso/espanso
# brew install espanso

# brew install --cask jetbrains-toolbox
# brew install --cask pycharm
# brew install --cask visual-studio-code qbittorrent rectangle android-platform-tools
# brew install --cask wireshark wireshark-chmodbpf alt-tab docker
# brew install --cask codeql beekeeper-studio iglance


INIT_DIR="$HOME/init"
PRIVATE_INIT_DIR="$HOME/cloud/private_init"

git clone https://github.com/chillaranand/init $INIT_DIR

# git clone https://github.com/agzam/spacehammer ~/.hammerspoon


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

mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bkp"
ln -s "$INIT_DIR/p10k.zsh" "$HOME/.p10k.zsh"

# ipython
python -m pip install ipython stdlib_list
ipython profile create
mv "$HOME/.ipython/profile_default/ipython_config.py" "/tmp/ipython_config.py"
ln -s "$INIT_DIR/ipython_config.py" "$HOME/.ipython/profile_default/ipython_config.py"

# karabiner
mv "$HOME/.config/karabiner/assets/complex_modifications/space_control.json" "/tmp/space_control.json"
ln -s "$INIT_DIR/karabiner_space_control.json" "$HOME/.config/karabiner/assets/complex_modifications/space_control.json"
ln -s "$INIT_DIR/karabiner_windows_remote.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_windows_remote.json"


# pyflash
mv "$HOME/.pyflash.ini" "/tmp/pyflash.ini"
ln -s "$PRIVATE_INIT_DIR/pyflash.ini" "$HOME/.pyflash.ini"

# zsh_history
#mv "$HOME/.zsh_history" "$HOME/.zsh_history.bkp"
#ln -s "$PRIVATE_INIT_DIR/zsh_history" "$HOME/.zsh_history"

# espanso
mv "$HOME/Library/Preferences/espanso/match/base.yml" "/tmp/base.yml"
ln -s "$PRIVATE_INIT_DIR/espanso.yml" "$HOME/Library/Preferences/espanso/match/base.yml"

# space hammer
git clone https://github.com/agzam/spacehammer ~/.hammerspoon
mv "$HOME/.hammerspoon/hammerspoon_init.lua" "/tmp/hammerspoon_init.lua"
ln -s "$HOME/init/hammerspoon_init.lua" "$HOME/.hammerspoon/hammerspoon_init.lua"


# mv "$HOME/.hammerspoon/userconfigprivate.lua" "/tmp/userconfigprivate.lua"
# ln -s "$HOME/init/hammerspoon/init.lua" "$HOME/.hammerspoon/userconfig.lua"
# ln -s "$PRIVATE_INIT_DIR/private_init.lua" "$HOME/.hammerspoon/userconfigprivate.lua"


# hammerspoon
# rm -rf "$HOME/.hammerspoon"
# mkdir -p "$HOME/.hammerspoon"
# ln -s "$HOME/init/hammerspoon_init.lua" "$HOME/.hammerspoon/init.lua"

echo "init.sh ran successfully"
