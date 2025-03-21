#! /bin/bash

set -x

echo "Setting up mac..."

export HOMEBREW_NO_AUTO_UPDATE=1

# show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures
# analog clock
defaults write com.apple.menuextra.clock IsAnalog -bool false

# install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_install() {
    for pkg in "$@"; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            echo "$pkg is already installed"
            continue
        fi
        brew install "$pkg"
    done
}

# ls 
brew_install eza vivid zsh zsh-syntax-highlighting tree zoxide

# utils
brew_install htop git nmap telnet watch wget 
brew_install fzf bat rg trash gnu-sed coreutils p7zip duf entr ripgrep 

# gui tools
brew_install stats git-gui iterm2

brew install --cask grandperspective rar kdiff3 hammerspoon visual-studio-code emacs
brew install --cask vlc google-drive karabiner-elements
brew install --cask --no-quarantine stretchly

npm install -g git-checkout-interactive

# archived

# brew install cheatsheet joplin obsidian graphviz
# brew install scrcpy jadx apktool wireshark postgresql mactex pandoc tunnelblick pulumi

# brew tap elastic/tap
# brew install elastic/tap/elasticsearch-full logstash-full kibana-full

# brew install --cask jetbrains-toolbox pycharm 
# brew install --cask wireshark wireshark-chmodbpf alt-tab docker
# brew install --cask codeql beekeeper-studio iglance


INIT_DIR="$HOME/init"
PRIVATE_INIT_DIR="$HOME/cloud/private_init"

git clone https://github.com/chillaranand/init $INIT_DIR


# emacs
mkdir -p "$HOME/.emacs.d"
ln -s "$INIT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
ln -s "$INIT_DIR/emacs/defaults.el" "$HOME/.emacs.d/defaults.el"
ln -s "$INIT_DIR/emacs/custom.el" "$HOME/.emacs.d/custom.el"
ln -s "$INIT_DIR/emacs/utils.el" "$HOME/.emacs.d/utils.el"


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# p10k
brew install font-hack-nerd-font
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

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
ln -s "$INIT_DIR/karabiner_ignore_tab.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_ignore_tab.json"
ln -s "$INIT_DIR/karabiner_iterm.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_iterm.json"
ln -s "$INIT_DIR/karabiner_alt_win.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_alt_win.json"

# pyflash
mv "$HOME/.pyflash.ini" "/tmp/pyflash.ini"
ln -s "$PRIVATE_INIT_DIR/pyflash.ini" "$HOME/.pyflash.ini"

# zsh_history
# mv "$HOME/.zsh_history" "$HOME/.zsh_history.bkp"
# ln -s "$PRIVATE_INIT_DIR/zsh_history" "$HOME/.zsh_history"

# hammerspoon
mkdir -p "$HOME/.hammerspoon"
ln -s "$HOME/init/hammerspoon_init.lua" "$HOME/.hammerspoon/init.lua"

# shortcut for icloud
# ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/cloud

echo "init.sh ran successfully"
