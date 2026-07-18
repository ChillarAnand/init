# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    cmdtime
    # z
    zoxide dirpersist extract git globalias kubectl
    zsh-autocomplete
    zsh-autosuggestions
    # pyautoenv
    # zsh-syntax-highlighting
)

# ZSH_THEME="ys2"
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

source $ZSH/oh-my-zsh.sh

# User configuration

# autocomplete
zstyle ':autocomplete:*' async no
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:*' widget-style menu-complete
zstyle ':autocomplete:*' delay 0.1

# zstyle ':autocomplete:*' list-lines 5
# zstyle ':autocomplete:history-search:*' list-lines 5
# zstyle ':autocomplete:history-incremental-search-*:*' list-lines 10
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 10

bindkey -M menuselect '^M' .accept-line
bindkey -M emacs '^N' menu-select

# .menu-complete = original built-in (zsh-autocomplete replaces menu-complete via zle -C).
# Original uses standard _cd completion (local dirs only, no history injection).
# Cycling works because LASTWIDGET == .menu-complete on each Tab press.
bindkey '^I' .menu-complete
bindkey "$terminfo[kcbt]" .reverse-menu-complete

autoload -Uz compinit && compinit

# cd: only local subdirs (no dirpersist stack)
zstyle ':completion:*:cd:*' tag-order 'local-directories path-directories'


# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8


# history
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

# no dups
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
if [[ -f ~/cloud/private_init/zsh_history ]]; then
    export HISTFILE=~/cloud/private_init/zsh_history
fi


# functions
pyclean () {
    sudo find . -type f -name "*.py[co]" -delete
    sudo find . -type d -name "__pycache__" -delete
}

disk_clean() {
    uv cache clean
    brew cleanup --scrub
    docker system prune --all --force --volumes
    sudo rm -rf ~/Library/Caches/*
    sudo rm -rf /Library/Caches/*
    sudo rm -rf /private/var/folders/*
}
alias dc=disk_clean

# alias
alias awk=gawk
alias bga='bench get-app'
alias bi='brew install'
alias bl='brew list'
alias bs='bench start'
alias bsa='brew services start'
alias bsak='brew services start kafka'
alias bsd='bench --site demo.localhost'
alias bse='bench --site edge.localhost'
alias bsec='bench --site edge.localhost console'
alias bsem='bench --site edge.localhost migrate'
alias bsl='brew services list'
alias bsr='brew services restart'
alias bst='bench --site t'
alias bsz='brew services stop'
alias bu='brew uninstall'
alias c='bat'
alias ca='conda activate'
alias charm='open -na "PyCharm.app" --args'
alias ci="curl ipinfo.io"
alias cie='conda info --envs'
alias cl="git clone"
alias dcu="docker compose up"
alias dj='uv run python manage.py'
alias dk='docker'
alias dmm='uv run python manage.py makemigrations'
# alias dm='uv run python manage.py migrate'
alias dr='uv run python manage.py runserver'
alias drr='docker run --rm'
alias gcom='gco master || gco main'
alias glo="git pull origin"
alias gpo="git push origin"
alias glom="git pull origin master || git pull origin main"
alias gpom="git push origin master"
alias gpc="git push origin HEAD"
alias gpcf="git push origin HEAD -f"
alias hgi='history | grep -i'
alias hgi='history | grep -i'
alias hwc='history | wc'
alias i='brew install'
alias im='curl https://raw.githubusercontent.com/ChillarAnand/init/main/mac.sh | bash'
alias iml='sh ~/init/mac.sh'
alias ipy='ipython'
alias jl='jupyter-lab'
alias j=just
alias f=z
alias jd="~/Downloads/"
alias jp="~/projects/"
alias js="~/projects/sandbox/"
alias ls='ls --color=tty'
alias ll='ls --color=tty -ll'
# alias l='ls --color=tty -ll'
alias l='eza --icons=always'
alias rf='trash'
alias o='orbctl start'
alias me='chmod +x'
alias mi='sh ~/init/init_mac.sh'
alias naf='j avilpage.com; trash output; trash cache; nikola auto'
alias p="ping 8.8.8.8"
alias pf='python -m pip freeze'
alias pgi='ps -ef | grep -i'
# alias pi='uv pip install'
alias piu='uv pip install -U'
alias pir='uv pip install -r'
alias pirr='uv pip install -r requirements.txt'
alias pu='uv pip uninstall -y'
alias py="python"
alias s=sudo
alias se='source .env'
# alias cat=gcat
alias sz='source ~/.zshrc'
alias spa='source ~/cloud/private_init/private_init_avilpage.sh'
alias t='tree -Cfh'
alias tgi='tree -Cfh | grep -i'
alias timeout=gtimeout
alias ts='tailscale'
alias tst='tailscale status'
alias ty='type'
alias w1='watch -n1'
alias proxy_off='sudo networksetup -setwebproxystate wi-fi off; sudo networksetup -setsecurewebproxystate wi-fi off'
alias proxy_on='sudo networksetup -setwebproxystate wi-fi on; sudo networksetup -setsecurewebproxystate wi-fi on'
alias kgpa='kubectl get pods --all-namespaces'
alias kci='kubectl cluster-info'
alias kc='kubectl'
alias kcgc='kubectl config get-contexts'
alias h=history
alias ja='j avilpage.com'
alias grep='grep --exclude-dir=.git --exclude-dir=.idea'
alias kcc='kafka-console-consumer --bootstrap-server localhost:9092 --topic'
alias kcp='kafka-console-producer --bootstrap-server localhost:9092 --topic'
alias kt='kafka-topics --bootstrap-server localhost:9092'
alias sv='ssh -v'
alias nrd='npm run dev'
alias ni='pnpm install'
alias ns='j sandbox; rm -rf demo; take demo; uv venv --seed --clear; source .venv/bin/activate'
alias na='z avilpage.com; uv run nikola auto'
alias ngd='ssh-add -D; ssh-add ~/.ssh/id_rsa; uv run nikola github_deploy'

# only for mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    # echo "mac"
    alias xargs=gxargs
    alias sed=gsed
fi


# env vars
export NIKOLA_MONO=true
export HOMEBREW_NO_AUTO_UPDATE=1

export LC_CTYPE=C
export LANG=C

# kafka - confluent-kafka
export C_INCLUDE_PATH=~/homebrew/Cellar/librdkafka/2.2.0/include
export LIBRARY_PATH=~/homebrew/Cellar/librdkafka/2.2.0/lib

# if [ -f /usr/libexec/java_home ]; then
#     export JAVA_HOME="$(/usr/libexec/java_home)"
#     export ES_JAVA_HOME="$JAVA_HOME"
# fi

export PATH="/Users/chillaranand/homebrew/opt/socket_vmnet/bin:$PATH"

export PYTHONDONTWRITEBYTECODE=1

export PATH="/Users/chillaranand/homebrew/opt/make/libexec/gnubin:$PATH"
# export LDFLAGS="-L/Users/chillaranand/homebrew/opt/zlib/lib"
# export CPPFLAGS="-I/Users/chillaranand/homebrew/opt/zlib/include"

# export LDFLAGS="$LDFLAGS -L/Users/chillaranand/homebrew/opt/libpq/lib"
# export CPPFLAGS="$CPPFLAGS -I/Users/chillaranand/homebrew/opt/libpq/include"

export LDFLAGS="-L/Users/chillaranand/homebrew/opt/curl/lib"
export CPPFLAGS="-I/Users/chillaranand/homebrew/opt/curl/include"

# export GDAL_LIBRARY_PATH="$(gdal-config --prefix)/lib/libgdal.dylib"
# export GEOS_LIBRARY_PATH="$(geos-config --prefix)/lib/libgeos_c.dylib"

export PATH="/Users/chillaranand/homebrew/sbin:$PATH"

ji() {
    python -m json.tool $1 > /tmp/a.json
    mv /tmp/a.json $1
}

export NODE_OPTIONS="--max-old-space-size=8192"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# autoload -Uz compinit
# zstyle ':completion:*' menu select
# fpath+=~/.zfunc

# [ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh
export PATH="/Users/chillaranand/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/chillaranand/homebrew/opt/dotnet@6/bin:$PATH"

# add Pulumi to the PATH
export PATH=$PATH:/Users/chillaranand/.pulumi/bin

export DOTNET_ROOT="/Users/chillaranand/homebrew/opt/dotnet/libexec"
export ELECTRON_DEV=true
export GOARCH="arm64"

export LS_COLORS="$(vivid generate ayu)"

alias dbc='osascript ~/init/setDefaultBrowser.scpt chrome'
alias dbb='osascript ~/init/setDefaultBrowser.scpt browser'

if [ -f ~/cloud/private_init/private_init.sh ]; then
    source ~/cloud/private_init/private_init.sh
fi
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export MCFLY_LIGHT=TRUE
# export MCFLY_DISABLE_MENU=TRUE
# eval "$(mcfly init zsh)"

# source /Users/chillaranand/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

my_chpwd_hook() {
    clear
    eza --icons=always
}

chpwd_functions+=( my_chpwd_hook )

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

# bun completions
[ -s "/Users/anand/.bun/_bun" ] && source "/Users/anand/.bun/_bun"

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"

export PATH="/Users/anand/.pixi/bin:$PATH"

# export SPACESHIP_PROMPT_ASYNC=false
# eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/anand/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Set default browser without macOS confirmation prompt
defbro-silent() {
    defbro "$1" &
    osascript -e "
    tell application \"System Events\"
        repeat 10 times
            try
                click button 1 of window 1 of process \"CoreServicesUIAgent\"
                exit repeat
            end try
            delay 0.5
        end repeat
    end tell"
}


# opencode
export PATH=/Users/anand/.opencode/bin:$PATH

# sentry
fpath=("/Users/anand/.local/share/zsh/site-functions" $fpath)

# Android SDK
export ANDROID_HOME=$HOME/Android/sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# WeasyPrint native libs (Pango/Cairo/GLib) — Homebrew on Apple Silicon
export DYLD_FALLBACK_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_FALLBACK_LIBRARY_PATH"

# rapid-mlx local model control (supervisor manual start; idle watchdog auto-stops)
alias mlx-up='supervisorctl -c ~/supervisord.conf start rapid-mlx-9004'
alias mlx-down='supervisorctl -c ~/supervisord.conf stop rapid-mlx-9004'
alias mlx-status='supervisorctl -c ~/supervisord.conf status rapid-mlx-9004'
