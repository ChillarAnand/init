# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # cmdtime
    dirpersist extract git globalias kubectl z
    zsh-autocomplete
    zsh-autosuggestions
    # zsh-syntax-highlighting
)

# ZSH_THEME="ys2"
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

source $ZSH/oh-my-zsh.sh

# User configuration
zstyle ':autocomplete:*' default-context history-incremental-search-backward

# zstyle ':autocomplete:*' list-lines 5
zstyle ':autocomplete:history-incremental-search-*:*' list-lines 10
zstyle ':autocomplete:history-search:*' list-lines 5

bindkey -M menuselect '^M' .accept-line
bindkey -M emacs '^N' menu-select

bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

zstyle ':autocomplete:*' ignored-input 'cd '
zstyle ':autocomplete:*' ignored-input 'cd ..'
zstyle ':autocomplete:*' ignored-input 'cd..'
zstyle ':autocomplete:*' ignored-input 'cd##'

autoload -Uz compinit && compinit

# Set up a style to ignore 'cd' command for auto-completions
zstyle ':completion:*:(cd):*' matcher-list '' 
zstyle ':completion:*:cd:*' matcher-list ''


# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8


# eval "$(starship init zsh)"
# export SPACESHIP_PROMPT_ASYNC=false
# source "/Users/chillaranand/homebrew/opt/spaceship/spaceship.zsh"

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
alias dcu='docker compose up'
alias dj='./manage.py'
alias dk='docker'
alias dm='./manage.py migrate'
alias dmm='./manage.py makemigrations'
alias dr='./manage.py runserver'
alias drr='docker run --rm'
alias ect='python etl_config_migration_scripts/ETL_Config_Tool.py'
alias edm='python etl_config_migration_scripts/ETL_Config_Tool.py -o overwrite -t config -f settings/etl_tool/dev.json -dc C97'
alias fb='fastboot'
alias flo='flash otp'
alias gcom='gco master'
alias glo="git pull origin"
alias glom="git pull origin master"
alias gpom="git push origin master"
alias gpc="git push origin HEAD"
alias gpcf="git push origin HEAD -f"
alias hgi='history | grep -i'
alias hgi='history | grep -i'
alias hwc='history | wc'
alias i='brew install'
alias im='sh ~/init/init_mac.sh'
alias ipy='ipython'
alias jl='jupyter-lab'
alias j=z
alias jd="~/Downloads/"
alias js="~/projects/sandbox/"
alias jq="~/projects/qontigo/"
alias l='exa -l'
alias lc='limactl'
alias ll='exa -l'
alias rf='trash'
alias o='orbctl start'
alias me='chmod +x'
alias mi='sh ~/init/init_mac.sh'
alias na='z avilpage.com; nikola auto'
alias naf='j avilpage.com; trash output; trash cache; nikola auto'
alias ngd='nikola github_deploy'
alias ngd='ssh-add -D; ssh-add ~/.ssh/id_rsa; nikola github_deploy'
alias p="ping 8.8.8.8"
alias pf='python -m pip freeze'
alias pgi='ps -ef | grep -i'
alias pi='python -m pip install'
alias pir='python -m pip install -r'
alias pirr='python -m pip install -r requirements.txt'
alias pu='python -m pip uninstall -y'
alias py="python"
alias s=sudo
alias se='source .env'
# alias cat=gcat
alias sz='source ~/.zshrc'
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


# only for mac
if [[ "$OSTYPE" == "darwin"* ]]; then
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

if [ -f /usr/libexec/java_home ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
    export ES_JAVA_HOME="$JAVA_HOME"
fi

export PATH="/Users/chillaranand/homebrew/opt/socket_vmnet/bin:$PATH"

export PYTHONDONTWRITEBYTECODE=1

export PATH="/Users/chillaranand/homebrew/opt/make/libexec/gnubin:$PATH"
export LDFLAGS="-L/Users/chillaranand/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/Users/chillaranand/homebrew/opt/zlib/include"

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


# rye
# source "$HOME/.rye/env"


# conda init zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/chillaranand/homebrew/Caskroom/mambaforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/chillaranand/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh" ]; then
        . "/Users/chillaranand/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/Users/chillaranand/homebrew/Caskroom/mambaforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# autoload -Uz compinit
# zstyle ':completion:*' menu select
# fpath+=~/.zfunc

# [ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh
export PATH="/Users/chillaranand/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/Users/chillaranand/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/Users/chillaranand/homebrew/opt/libpq/include"
export PATH="/Users/chillaranand/homebrew/opt/dotnet@6/bin:$PATH"

# add Pulumi to the PATH
export PATH=$PATH:/Users/chillaranand/.pulumi/bin

export DOTNET_ROOT="/Users/chillaranand/homebrew/opt/dotnet/libexec"
export ELECTRON_DEV=true
export GOARCH="arm64"

alias dbc='osascript ~/init/setDefaultBrowser.scpt chrome'
alias dbb='osascript ~/init/setDefaultBrowser.scpt browser'

if [ -f ~/cloud/private_init/private.sh ]; then
    source ~/cloud/private_init/private.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export MCFLY_LIGHT=TRUE
# export MCFLY_DISABLE_MENU=TRUE
# eval "$(mcfly init zsh)"

# source /Users/chillaranand/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
