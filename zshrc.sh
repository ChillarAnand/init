# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # cmdtime
    dirpersist
    extract
    git
    z
    # zsh-autocomplete
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# ZSH_THEME="ys"
# ZSH_THEME="ys2"

source ~/powerlevel10k/powerlevel10k.zsh-theme

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


# zstyle ':autocomplete:*' default-context history-incremental-search-backward
# zstyle ':autocomplete:*' widget-style menu-select
# zstyle ':autocomplete:tab:*' widget-style menu-complete


# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' down-line-or-select
# bindkey '^[[B' down-line-or-select
# bindkey '^[OB' down-line-or-select


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
alias hgi='history | grep -i'
alias hgi='history | grep -i'
alias hwc='history | wc'
alias i='brew install'
alias im='sh ~/init/init_mac.sh'
alias ipy='ipython'
alias j=z
alias ja='j avilpage.com; ssh-add -D; ssh-add ~/.ssh/id_rsa'
# alias jd="~/Downloads/"
alias jl='jupyter-lab'
alias jl='just -l'
alias jra='just a'
alias js="~/projects/sandbox/"
alias kcc='kafka-console-consumer'
alias kcp='kafka-console-producer'
alias kss='kafka-server-start'
alias kssk='kafka-server-start $HOME/homebrew/etc/kafka/kraft/server.properties'
alias l='exa -l'
alias lc='limactl'
alias lca='limactl start'
alias lcl='limactl list'
alias lcr='limactl stop default; limactl delete default; limactl start default --tty=false'
alias lcs='lc shell'
alias lcz='limactl stop'
alias lima='limactl start default; lima'
alias ll='exa -l'
alias me='chmod +x'
alias mi='sh ~/init/init_mac.sh'
alias mp='multipass'
alias mpl='multipass list'
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
alias pu='python -m pip uninstall'
alias py="python"
alias s=sudo
alias se='source .env'
alias sed=gsed
alias cat=gcat
alias sz='source ~/.zshrc'
alias t='tree -Cfh'
alias tgi='tree -Cfh | grep -i'
alias timeout=gtimeout
alias ts='tailscale'
alias tst='tailscale status'
alias ty='type'
alias w1='watch -n1'
alias wo='workon'
alias xargs=gxargs
alias proxy_off='sudo networksetup -setwebproxystate wi-fi off; sudo networksetup -setsecurewebproxystate wi-fi off'
alias proxy_on='sudo networksetup -setwebproxystate wi-fi on; sudo networksetup -setsecurewebproxystate wi-fi on'
alias kgpa='kubectl get pods --all-namespaces'
alias kci='kubectl cluster-info'
alias kcgc='kubectl config get-contexts'


# env vars
export NIKOLA_MONO=true
export HOMEBREW_NO_AUTO_UPDATE=1

export LC_CTYPE=C
export LANG=C

# kafka - confluent-kafka
export C_INCLUDE_PATH=~/homebrew/Cellar/librdkafka/2.2.0/include
export LIBRARY_PATH=~/homebrew/Cellar/librdkafka/2.2.0/lib

export JAVA_HOME="$(/usr/libexec/java_home)"
export ES_JAVA_HOME="$JAVA_HOME"

export PATH="/Users/chillaranand/homebrew/opt/socket_vmnet/bin:$PATH"

# export WORKON_HOME=$HOME/.virtualenvs
# source /Library/Frameworks/Python.framework/Versions/3.9/bin/virtualenvwrapper.sh

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


# source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/cloud/private_init/private.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# rye
source "$HOME/.rye/env"


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
