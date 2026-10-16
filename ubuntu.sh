#! /bin/bash
set -u

echo "Setting up ubuntu..."

export DEBIAN_FRONTEND=noninteractive

INIT_DIR="$HOME/init"
PRIVATE_INIT_DIR="$HOME/cloud/private_init"

# clone or update a git repo
git_sync() {
    if [ -d "$2" ]; then
        git -C "$2" pull
    else
        git clone --depth=1 "$1" "$2"
    fi
}

# move a real file aside once; skip if missing or already our symlink
backup() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then mv "$1" "$2"; fi
}

# packages
sudo apt update
sudo apt install --yes byobu git trash-cli tree unzip vim zsh
sudo apt install --yes nmap net-tools telnet iotop-c htop atop

git_sync https://github.com/chillaranand/init "$INIT_DIR"

# oh-my-zsh
grep -qxF 'skip_global_compinit=1' "$HOME/.zshenv" 2>/dev/null || echo 'skip_global_compinit=1' >> "$HOME/.zshenv"
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# p10k + zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git_sync https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
git_sync https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git_sync https://github.com/tom-auger/cmdtime "$ZSH_CUSTOM/plugins/cmdtime"

# zsh-autocomplete: pinned to last pre-zasync (sync) commit + local fd-leak patch.
# Newer upstream is always-async and broke autocomplete here.
AUTOCOMPLETE_DIR="$ZSH_CUSTOM/plugins/zsh-autocomplete"
[ -d "$AUTOCOMPLETE_DIR" ] || git clone https://github.com/marlonrichert/zsh-autocomplete "$AUTOCOMPLETE_DIR"
git -C "$AUTOCOMPLETE_DIR" checkout -q 20f6c34
git -C "$AUTOCOMPLETE_DIR" apply --check "$INIT_DIR/zsh-autocomplete-fd.patch" 2>/dev/null &&
    git -C "$AUTOCOMPLETE_DIR" apply "$INIT_DIR/zsh-autocomplete-fd.patch"

backup "$HOME/.zshrc" "$HOME/.zshrc.bkp"
ln -sf "$INIT_DIR/zshrc.sh" "$HOME/.zshrc"

backup "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bkp"
ln -sf "$INIT_DIR/p10k.zsh" "$HOME/.p10k.zsh"

echo "ubuntu.sh ran successfully"

if [ -d "$PRIVATE_INIT_DIR" ]; then
    echo "Found private init dir, running private init..."
    bash "$PRIVATE_INIT_DIR/init.sh"
fi
