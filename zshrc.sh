# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="ys"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.



plugins=(
    cmdtime
    dirpersist
    extract
    git
    z
    # zsh-autocomplete
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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


# functions

pyclean () {
    sudo find . -type f -name "*.py[co]" -delete
    sudo find . -type d -name "__pycache__" -delete
}


# ZSH_THEME="ys"
ZSH_THEME="powerlevel10k/powerlevel10k"



# history
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

# no dups
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE


zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:*' widget-style menu-select
# zstyle ':autocomplete:tab:*' widget-style menu-complete


# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' down-line-or-select
# bindkey '^[[B' down-line-or-select
# bindkey '^[OB' down-line-or-select



# alias
alias bsl='brew services list'
alias bsa='brew services start'
alias bsz='brew services stop'

alias c=bat

alias ci="curl ipinfo.io"

alias cl="git clone"

alias dk='docker'
alias drr='docker run --rm'
alias dcu='docker compose up'

alias flo='flash otp'

alias hgi='history | grep -i'

alias gcom='gco master'

alias kcc='kafka-console-consumer'
alias kcp='kafka-console-producer'
alias kss='kafka-server-start'
alias kssk='kafka-server-start $HOME/homebrew/etc/kafka/kraft/server.properties'

alias ja='j avilpage.com'

alias j=z
alias js="~/projects/sandbox/"
alias jd="~/Downloads/"

alias i='brew install'

alias l='exa -l'
alias ll='exa -l'

alias me='chmod +x'

alias p="ping 8.8.8.8"

alias py="python"
alias ipy='ipython'

alias t='tree -Cfh'

alias s=sudo

# gnu utils
alias sed=gsed
alias timeout=gtimeout
alias xargs=gxargs


alias sz='source ~/.zshrc'


alias na='j avilpage.com; nikola auto'
alias ngd='nikola github_deploy'
alias ngd='ssh-add -D; ssh-add ~/.ssh/id_rsa; nikola github_deploy'
alias naf='j avilpage.com; trash output; trash cache; nikola auto'

alias ty='type'
alias rm='trash'
alias rf='trash'


alias pirr='python -m pip install -r requirements.txt'
alias pi='python -m pip install'
alias pf='python -m pip freeze'
alias pir='python -m pip install -r'
alias wo='workon'

alias pgi='ps -ef | grep -i'
alias tgi='tree -Cfh | grep -i'
alias hgi='history | grep -i'


# env vars
export NIKOLA_MONO=true
export HOMEBREW_NO_AUTO_UPDATE=1


export LC_CTYPE=C
export LANG=C

# list files on new tab
# exa


# kafka - confluent-kafka
export C_INCLUDE_PATH=~/homebrew/Cellar/librdkafka/1.9.2/include
export LIBRARY_PATH=~/homebrew/Cellar/librdkafka/1.9.2/lib

export JAVA_HOME="$(/usr/libexec/java_home)"
export ES_JAVA_HOME="$(/usr/libexec/java_home)"


export WORKON_HOME=$HOME/.virtualenvs
source /Library/Frameworks/Python.framework/Versions/3.9/bin/virtualenvwrapper.sh


export PYTHONDONTWRITEBYTECODE=1
