#! /bin/bash

echo "Setting up mac..."

export HOMEBREW_NO_AUTO_UPDATE=1

# show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures
# analog clock
defaults write com.apple.menuextra.clock IsAnalog -bool false

# xcode command line tools (brew needs these; fresh mac has none)
if ! xcode-select -p >/dev/null 2>&1; then
    echo ">>> Xcode Command Line Tools missing."
    echo ">>> A GUI dialog should pop up. Click 'Install' and wait for it to finish."
    sudo xcode-select --install 2>/dev/null
    echo ">>> If NO dialog appeared, run manually in another Terminal:"
    echo ">>>     sudo rm -rf /Library/Developer/CommandLineTools"
    echo ">>>     sudo xcode-select --install"
    echo ">>> Waiting for command-line tools to finish installing..."
    while ! xcode-select -p >/dev/null 2>&1; do
        printf '.'
        sleep 10
    done
    echo " done."
fi

# install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# add brew to PATH for this shell (Apple Silicon: /opt/homebrew, Intel: /usr/local)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# bail if brew still missing
if ! command -v brew >/dev/null 2>&1; then
    echo "ERROR: homebrew install failed. Fix before continuing." >&2
    exit 1
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

# install cask only if missing; skip if app already present (avoids
# downgrading self-updating apps like zed/vscode/chrome that brew lags on)
brew_cask_install() {
    for pkg in "$@"; do
        if brew list --cask -1 | grep -q "^${pkg}\$"; then
            echo "$pkg cask already installed"
            continue
        fi
        brew install --cask --adopt "$pkg"
    done
}

# move a real file aside once; skip if missing or already our symlink
backup() {
    [ -e "$1" ] && [ ! -L "$1" ] && mv "$1" "$2"
}

# ls
brew_install eza vivid zsh zsh-syntax-highlighting tree zoxide

# utils
brew_install htop git nmap telnet uv watch wget
brew_install fzf bat trash gnu-sed coreutils p7zip duf entr ripgrep

# gui tools
brew_install stats git-gui iterm2

brew_cask_install hammerspoon visual-studio-code emacs raycast shottr zed
brew_cask_install grandperspective google-chrome google-drive karabiner-elements vlc

npm install -g git-checkout-interactive

INIT_DIR="$HOME/init"
PRIVATE_INIT_DIR="$HOME/cloud/private_init"

[ -d "$INIT_DIR" ] || git clone https://github.com/chillaranand/init "$INIT_DIR"

# emacs
mkdir -p "$HOME/.emacs.d"
ln -sf "$INIT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
ln -sf "$INIT_DIR/emacs/defaults.el" "$HOME/.emacs.d/defaults.el"
ln -sf "$INIT_DIR/emacs/custom.el" "$HOME/.emacs.d/custom.el"
ln -sf "$INIT_DIR/emacs/utils.el" "$HOME/.emacs.d/utils.el"

# oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# p10k
brew_install font-hack-nerd-font
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ] || git clone https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"

backup "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -sf "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

backup "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bkp"
ln -sf "$INIT_DIR/p10k.zsh" "$HOME/.p10k.zsh"

# karabiner
backup "$HOME/.config/karabiner/assets/complex_modifications/space_control.json" "/tmp/space_control.json"
ln -sf "$INIT_DIR/karabiner_space_control.json" "$HOME/.config/karabiner/assets/complex_modifications/space_control.json"
ln -sf "$INIT_DIR/karabiner_windows_remote.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_windows_remote.json"
ln -sf "$INIT_DIR/karabiner_windows_app.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_windows_app.json"
ln -sf "$INIT_DIR/karabiner_ignore_tab.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_ignore_tab.json"
ln -sf "$INIT_DIR/karabiner_iterm.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_iterm.json"
ln -sf "$INIT_DIR/karabiner_alt_win.json" "$HOME/.config/karabiner/assets/complex_modifications/karabiner_alt_win.json"

# zsh_history
backup "$HOME/.zsh_history" "$HOME/.zsh_history.bkp"
ln -s "$PRIVATE_INIT_DIR/zsh_history" "$HOME/.zsh_history"

# hammerspoon
mkdir -p "$HOME/.hammerspoon"
ln -sf "$HOME/init/hammerspoon_init.lua" "$HOME/.hammerspoon/init.lua"

echo "init.sh ran successfully"
