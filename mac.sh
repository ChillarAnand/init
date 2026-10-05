#! /bin/bash
set -u

echo "Setting up mac..."

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INTERACTIVE=1

INIT_DIR="$HOME/init"
PRIVATE_INIT_DIR="$HOME/cloud/private_init"

# show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures
# digital clock
defaults write com.apple.menuextra.clock IsAnalog -bool false

# xcode command line tools (brew installer triggers the GUI install)
if ! xcode-select -p >/dev/null 2>&1; then
    echo ">>> Installing Xcode Command Line Tools. Click 'Install' in the dialog."
    xcode-select --install 2>/dev/null
    until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

# install homebrew, add to PATH (Apple Silicon: /opt/homebrew, Intel: /usr/local)
command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
command -v brew >/dev/null 2>&1 || { echo "ERROR: homebrew install failed. Fix before continuing." >&2; exit 1; }

# clone or update a git repo
git_sync() {
    if [ -d "$2" ]; then
        git -C "$2" pull --autostash
    else
        git clone --depth=1 "$1" "$2"
    fi
}

# move a real file aside once; skip if missing or already our symlink
backup() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then mv "$1" "$2"; fi
}

git_sync https://github.com/chillaranand/init "$INIT_DIR"

# packages
brew bundle --file="$INIT_DIR/Brewfile"
duti -s dev.zed.Zed .md all

# start ActivityWatch on login
if ! osascript -e 'tell application "System Events" to get the name of every login item' | grep -q "ActivityWatch"; then
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/ActivityWatch.app", hidden:false}'
fi

command -v npm >/dev/null 2>&1 && npm install -g git-checkout-interactive

# emacs
mkdir -p "$HOME/.emacs.d"
for f in init defaults custom utils; do
    ln -sf "$INIT_DIR/emacs/$f.el" "$HOME/.emacs.d/$f.el"
done

# oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# p10k + zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git_sync https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
git_sync https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git_sync https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"

backup "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -sf "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

backup "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bkp"
ln -sf "$INIT_DIR/p10k.zsh" "$HOME/.p10k.zsh"

# karabiner
KARABINER_DIR="$HOME/.config/karabiner/assets/complex_modifications"
mkdir -p "$KARABINER_DIR"
for f in "$INIT_DIR"/karabiner*.json; do
    ln -sf "$f" "$KARABINER_DIR/$(basename "$f")"
done

# zsh_history
backup "$HOME/.zsh_history" "$HOME/.zsh_history.bkp"
ln -sf "$PRIVATE_INIT_DIR/zsh_history" "$HOME/.zsh_history"

# hammerspoon
mkdir -p "$HOME/.hammerspoon"
ln -sf "$INIT_DIR/hammerspoon_init.lua" "$HOME/.hammerspoon/init.lua"

echo "mac.sh ran successfully"

if [ -d "$PRIVATE_INIT_DIR" ]; then
    echo "Found private init dir, running private init..."
    bash "$PRIVATE_INIT_DIR/init.sh"
fi
