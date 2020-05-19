# links
# ln ~/.custom_zsh/zshrc ~/.zshrc
# ln ~/.custom_zsh/themes/ys2.zsh-theme ~/.oh-my-zsh/themes/ys2.zsh-theme

# source /usr/local/share/antigen/antigen.zsh


ZSH_DISABLE_COMPFIX="true"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# best-themes-list - half-life, ys, steef, sorin, jonathan(line)

# ZSH_THEME="ys2"
ZSH_THEME="ys"
# ZSH_THEME="Powerlevel9k"

# POWERLEVEL9K_MODE='awesome-fontconfig'
# source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# ZSH_THEME="sobole"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"
HIST_STAMPS="%d/%m/%y %T"


# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/projects/01/ubuntu/config/zsh
ZSH_CUSTOM=~/projects/eddie/ubuntu/config/zsh


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git z extract dirpersist autoenv web-search pip zsh-autosuggestions)
plugins=(git z extract dirpersist pip)




# User configuration

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacsclient'
else
    export EDITOR='emacsclient'
    export EDITOR='vim '
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"







# user config
BASE_DIR=$HOME'/projects/eddie'


# set utf8
LANG="en_US.UTF-8"
# LANG="te_IN.UTF-8"
export LC_ALL=$LANG
export LANG=$LANG
export LANGUAGE=$LANG


# source /etc/profile.d
if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi



# virtualenv wrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# source /usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper.sh


export PYTHONDONTWRITEBYTECODE=1
alias pd='j py && ipy'
alias p2='wo py27'

alias wo='workon'
alias wp='workon py35'
alias wj='workon py35'
# alias we='workon exp'






# Load pyenv automatically
# export PATH="/home/anand/.pyenv/bin:$PATH"
# export PATH="/Users/curatech/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"




# shell escape chars
export TERM=xterm-256color

export PYTHONDONTWRITEBYTECODE=False

export THEANO_FLAGS='floatX=float32'

# source $ZSH_CUSTOM/aliases.sh




if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# path
export PATH="~/.pyenv/bin:$PATH"
export PATH="~/projects/eddie/ubuntu/bin:$PATH"
export PATH="~/projects/vendor/arduino:$PATH"
export PATH="/home/chillar/projects/vendor/arduino:$PATH"


# vagrant
export VAGRANT_DEFAULT_PROVIDER=virtualbox


# history
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

export HISTSIZE=10000000000
export SAVEHIST=$HISTSIZE


function search {
    grep -irl \
        --exclude=\*.{pyc,swp,un~,png,jpg} \
        --exclude-dir=".git" \
        --exclude-dir="node_modules" \
        --exclude-dir="bower_components" \
        --exclude-dir="dist" \
        --exclude-dir="tmp" \
        --exclude-dir=".sass_cache" \
        --exclude-dir="build" \
        --exclude-dir="uploads" \
        --color "$*" .
}

alias a=alias
alias al='alias | le'

alias j=z

alias ja='j avilpage.com'
alias jd='cd ~/Downloads/'
alias jp='cd ~/projects/'
alias jpi='cd ~/Pictures/'
alias js='cd ~/projects/sandbox'
alias jv='cd ~/Videos/'

jpy() {
    cd ~/projects/notes/python/
    workon exp
}


alias b='byobu'

os='mac'

if [[ os == 'linux' ]]; then
    alias i='sudo apt install --yes'
    alias ag='sudo apt-get'
    alias au='sudo apt-get update -qq'
    alias sap='sudo apt purge '

    alias sdi='sudo dpkg -i'
else
    alias i='brew install'
    alias bi='brew install'
    alias brm='brew remove'
    alias bci='brew cask install'
fi


apt_clean () {
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
}


alias cf='clementine -f'
alias ch='nohup google-chrome > /dev/null &'
alias cr='clementine -r'


alias de='sudo salt master state.highstate saltenv=web'

alias pgi='ps -ef | grep -i'



# python aliases
alias py='python'
alias ipy='ipython'
alias py2='python2'
alias ipy2='ipython2'

alias da='deactivate'
alias pf='pip freeze | sort'
alias pfl='pip freeze | sort | less'
alias pi='pip install'
alias pie='pip install -e .'
alias piu='pip install --upgrade'
alias pu='pip uninstall --yes'
alias piup='pip install --upgrade pip'

alias pir='pip install -r'
alias pirr='pip install -r requirements.txt'
alias pire='pip install --upgrade jedi rope flake8 importmagic autopep8 yapf'
alias pird="pip install -r $BASE_DIR'/ubuntu/config/requirements.txt'"



alias dp='j py && workon py35 && ipython'


pfi () {
    pip uninstall $1 --yes
    pip install $1 --no-cache-dir
}




alias psi='python setup.py install'

alias pt="pytest -vx --ff"
alias pti="pytest -vx --ff --ipdb"

alias nb='ipython notebook'
alias jn='jupyter notebook'
alias 1n='cd ~/.01/python; jupyter notebook python3.ipynb'

alias dj="python manage.py"
alias djc="python manage.py createsuperuser"
alias djcd="python manage.py createsuperuser --username f --email a@a.com"

alias dm="python manage.py migrate"
alias dmm="python manage.py makemigrations"
alias dmmm="dmm && dm"

alias dr="python manage.py runserver --no-color"

# alias dr="python manage.py runserver_plus --pm --no-color 0.0.0.0:8000"
alias drp="python manage.py runserver_plus"
alias drps="python manage.py runserver_plus --print-sql --pm --no-color 0.0.0.0:8000"

alias ds="python manage.py shell_plus --print-sql"
alias dsp="python manage.py shell_plus"
alias dsps="python manage.py shell_plus --print-sql"

alias dsu="python manage.py show_urls"
alias dsug="python manage.py show_urls | grep "

alias dn='python manage.py shell_plus --notebook'
alias dcm='python manage.py compilemessages && python manage.py makemessages'



alias du='du -hs'

alias e='ember '
alias es='ember server'
alias eg='ember generate '

alias e='nohup emacs >/dev/null &'
# alias f='flash '

# alias fk='fuck '
# eval "$(thefuck --alias)"


alias hs='history'
# alias hg='history | grep'
alias hgi='history | grep -i'

alias ht='htop'
alias at='atop'

alias p='ping 8.8.8.8'


alias jobs='jobs -l'

alias k='kill -9'
alias pk='pkill'
alias ka='killall '
# alias ke='killall emacs'
alias kb="pgi byobu | awk '{print $2}' | xargs kill -9 "

alias l='clear && ls'
alias l='ll'

alias le=less




# git
alias lg1=log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
alias lg2=log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
alias lg="git lg1"


alias gcl="git clone"
alias cl="git clone"

alias gi="git init"

alias gf='git fetch'
alias gfo='git fetch origin'
alias fod='git fetch origin develop'
alias fodd='git fetch origin develop:develop'
alias fom='git fetch origin master'
alias fomm='git fetch origin master:master'

alias glu="git pull upstream"
alias glum="git pull upstream master"
alias lumm="git pull upstream master:master"

alias gsuo="git pull upstream master && git push origin master"
alias gsy="git pull upstream master && git push origin master"

alias gcom="git checkout master"
alias gcod="git checkout develop"

alias gla="git pull --all"

alias glum="git pull upstream master"
alias lum=glum

alias glo="git pull origin"
alias gpo="git pull origin"
alias glod="git pull origin develop"
alias lodd="git pull origin develop:develop"
alias glom="git pull origin master"


alias gp="git push --set-upstream"

alias gpdm="git push deis master"
alias pdm=gpdm

alias gpom="git push origin master"
alias pom="git push origin master"

alias gphm="git push heroku master"
alias gphm="git push heroku master -f"
alias phm="git push heroku master"
alias phf="git push heroku master -f"

alias gpp="git pull && git push"

alias gsm="git pull upstream master && git push origin master"

alias gsw='git standup -d 7'
alias sw=gsw



alias mux=tmuxinator
alias m=mux
alias ml='mux list'

alias ma='mux avilpage'
alias mak='mux ak'
alias mj='mux junction'

alias tk='tmux kill-session -t '

alias cia='celery inspect active'
alias cpf='celery purge --force'
alias pkc='pkill -f celery'
alias pks='sudo pkill screen'


# alias ma=man

alias me='chmod +x '


alias nt='nautilus .'

alias n='nikola'
alias na='nikola auto'
alias naa='j avilpage.com; wo avilpage; nikola auto'
alias naf='rf output cache && rf cache && nikola auto'
# alias ng='nikola github_deploy'
alias ngd='nikola github_deploy'
alias nn='nikola new_post'


alias re='sudo shutdown -r 0'
alias re='sudo reboot'
alias rf='rm -rf'



alias cs=$BASE_DIR'/ubuntu/bin/xcape.sh'
alias bs=$BASE_DIR'/ubuntu/bin/bootstrap.sh'
alias spd=$BASE_DIR'/ubuntu/bin/proc.sh'
# spd

alias us="sudo ansible-playbook $BASE_DIR'/ubuntu/config/playbooks/ubuntu.yml' -i localhost, -c local"


alias s=sudo
alias si='sudo -i'
# alias sp='sudo du -hs *'

alias se='source .env'
alias sz='source ~/.zshrc'

alias sd='source ~/Dropbox/env'
alias db='~/.dropbox-dist/dropboxd'

alias sy='rsync -raz --progress'
alias rp='rsync -razP'

alias t='tree -Cfh'

alias wi='whereis'

alias yd='youtube-dl '

alias lh='http://127.0.0.1:8000'

alias ct='crontab '



# adb
# alias ad='python /home/chillaranand/projects/appknox/python-adb/adb.zip '
# alias add='python /home/chillaranand/projects/appknox/python-adb/adb.zip devices'
# alias ad1='python /home/chillaranand/projects/appknox/python-adb/adb.zip -s T00940Z1AS'
# alias a1='python /home/chillaranand/projects/appknox/python-adb/adb.zip -s T00940Z1AS'
# alias a2='python /home/chillaranand/projects/appknox/python-adb/adb.zip -s T00940ZT2K'


alias ai='adb install '
alias aid='ai -r app/build/outputs/apk/app-debug.apk'
alias aid='ai -r app/build/outputs/apk/debug/app-debug.apk'
alias ac='adb connect'
alias ad='adb devices '
alias aks='adb kill-server; adb start-server; adb devices'
# alias at='adb shell '
alias app='adb push -p '

aps() {
    adb push -p $1 /sdcard/
}

alias arr='adb reboot recovery '
alias arn='adb reboot'
alias arb='adb reboot bootloader '


alias fb='sudo fastboot '
alias fbd='sudo fastboot devices'
alias fd='sudo fastboot devices'




alias wifi='nmcli dev wifi '
alias wf=wifi

wco () {
    nmcli dev wifi connect $1 password $2 name $1
}

ncu () {
    nmcli con up id $1
}


alias ram="watch -n3 'sudo ps_mem | tail -n+2 | head -n-3 | tail -n10 | tac'"

alias v='vagrant '
alias vd='vagrant destroy -f'
alias vr='vagrant reload'
alias vs='vagrant ssh'
alias vst='vagrant status'
alias vsc='vagrant ssh-config'
alias vu='vagrant up'
alias vgs='vagrant global-status'



scs () {
    sudo systemctl --no-pager status $1.service
}

scst () {
    sudo systemctl --no-pager stop $1.service
    sudo systemctl --no-pager status $1.service
}

# scr () {
#     sudo systemctl --no-pager restart $1.service
#     sudo systemctl --no-pager status $1.service
# }

ssr() {
    sudo service $1 restart
}


alias as='adb shell'


alias ci='curl ipinfo.io'


alias cg="curl -X GET"
alias cag="curl -H 'Authorization: Token $AUTH_TOKEN' -H 'Accept: application/json; indent=4' -X GET"

alias cap="curl -H 'Authorization: Token $AUTH_TOKEN' -H 'Accept: application/json; indent=4' -X POST"
alias capa="curl -H 'Authorization: Token $AUTH_TOKEN' -H 'Accept: application/json; indent=4' -X PATCH"

alias chp="curl -H 'Accept: application/json; indent=4' -X POST"
alias chg="curl -H 'Accept: application/json; indent=4' -X GET"


alias c='cat '
alias cc='pygmentize -g'
alias o='xdg-open '

alias ts='pirate-get '

alias banti='python /home/chillaranand/projects/python/ocr/banti_telugu_ocr/recognize.py'


function ne() {
    docker run --rm -v "$(pwd)/`dirname ${@:$#}`":/ne/input -it alexjc/neural-enhance ${@:1:$#-1} "input/`basename ${@:$#}`";
};

alias enhance=ne


# docker
alias dk=docker

alias dkb=dk' build'
alias dkbc=dk' build .'
alias dbc=dk' build .'

alias dki=dk' images'


alias dkps=dk' ps'
alias dps=dk' ps'
alias dkps=dk' ps'
alias dkpsa=dk' ps -a'
alias dpa=dk' ps -a'
alias dpaq=dk' ps -aq'

alias dkr=dk' run'


alias dkc='sudo docker-compose'
alias dkc='docker-compose'

alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcr='docker-compose run'
alias dcrr='docker-compose run --rm'
alias dcu='docker-compose up'

alias dcdu='docker-compose --log-level debug up'





# alias rs='./scripts/start_server.sh'
# alias sss='./scripts/start_server.sh'
alias ssc='./scripts/start_celery.sh'
alias st='./scripts/test.sh'
alias sta='./scripts/test_api.sh'
alias stw='./scripts/test_ws.sh'


ifs () {
    rm -rf test_build
    mkdir test_build
    ./autogen.sh
    ./configure
    make
    make install
}



alias fl=flash
alias tv=tvol




alias rnm='sudo systemctl restart NetworkManager'
alias rps='sudo systemctl restart '

alias sub='subliminal download -s -l en '
alias subs='subliminal download -s -l en '



pyclean () {
    sudo find . -type f -name "*.py[co]" -delete
    sudo find . -type d -name "__pycache__" -delete
}


alias sc='sudo systemctl '
alias scr='sudo systemctl restart'



minikubea() {}

alias mk='minikube '
alias mks='minikube start'
alias mkt='minikube status'
alias mko='minikube stop'




kubectla() {}

vagrant_kube () {
    export KUBE_ENABLE_INSECURE_REGISTRY=true
    export KUBERNETES_PROVIDER=vagrant
    export KUBERNETES_MASTER_MEMORY=1536
    export KUBERNETES_NODE_MEMORY=4096
}


alias kc='kubectl '

alias kca='kubectl apply'
alias kaf='kubectl apply -f'

kcp() {
    kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}') | grep 'token:' | awk '{print $2}' | pbcopy
    open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
    # open 'http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=_all'
    kubectl proxy
}

alias kci='kubectl cluster-info'


alias kcc='kubectl create'

alias kcgc='kubectl config get-contexts'
alias kccc='kubectl config current-context'
alias kcv='kubectl config view'
alias kcu='kubectl config use-context'
alias kcum='kubectl config use-context minikube'
alias ksn='kubectl config set-context --current --namespace'


alias kd='kubectl describe'

alias kddp='kubectl --namespace=deis describe pod '

alias kdd='kubectl describe deployments'

alias kdel='kubectl delete'


alias kx='kubectl delete'
alias kxp='kubectl delete pod'
alias kdxp='kubectl -n deis delete pod'


alias kdp='kubectl describe pods'
alias kddp='kubectl describe pods -n deis'
alias ksdp='kubectl describe pods -n sherlock'

alias kds='kubectl describe services'


alias ke='kubectl exec'
alias ket='kubectl exec -it'
alias ked='kubectl exec -n deis'


alias kg='kubectl get '
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'

alias kgd='kubectl get deployments'
alias kgda='kubectl get deployments --all-namespaces'

alias kgn='kubectl get nodes'

alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kpa=kgpa
alias pa=kgpa

alias kgpd='kubectl get pods --namespace=deis'
alias kdgp='kubectl --namespace=deis get pod'
alias kgpk='kubectl get pods --namespace=kube-system'
alias kgps='kubectl get pods --namespace=sherlock'

alias kgs='kubectl get services'
alias kgsa='kubectl get services --all-namespaces'
alias ksa='kubectl get services --all-namespaces'

alias kl='kubectl logs'
alias kld='kubectl logs --namespace=deis'


alias knd='kubectl --namespace=deis'

alias kdsd='kubectl --namespace=deis describe svc deis-router'


alias kk='kubectl --namespace=kube-system'

alias ksi='kubectl set image'

alias kts='kubetail sherlock -n sherlock'
alias ktd='kubetail deis -n deis'

alias sv='ssh -v'
alias sv='snakeviz'



ssh_pod() {
    kubectl exec $1 -it bash --namespace=sherlock
}
alias sp=ssh_pod





deisa() {}

alias di='deis '

alias dad='deis apps:destroy -a'
alias dal='deis apps:list'

alias dka='deis keys:add'
alias dkl='deis keys:list'

alias dii='deis info'

alias dl='deis logs'

# alias dp='deis ps'

alias drr='deis releases | tac'



helma() {}
alias hla='helm ls --all'




awsa() {}

alias ae='aws ec2'
alias aed='aws ec2 describe-instances'
alias aei="aed --output table --query 'Reservations[].Instances[].[Tags[?Key==\`Name\`] | [0].Value, State.Name, PublicDnsName, PublicIpAddress]'"
alias ael="aws ec2 describe-instances --output table --query 'Reservations[].Instances[].[Tags[?Key==\`Name\`] | [0].Value, State.Name, PublicDnsName, PublicIpAddress]'"

# alias as='aws s3'
alias asc='aws s3 cp'
alias asl='aws s3 ls'

sld () {
    aws s3 ls --summarize --human-readable s3://$1
}

slrd () {
    aws s3 ls --summarize --human-readable --recursive s3://$1
}







# make aliases work with sudo
alias sudo='sudo '



export EDITOR=vim



# alias h='http '
# alias hs='http --session=tmp/session.json '

alias wl='http :8000'


export TZ=Asia/Kolkata

alias ty=type

alias ap='sudo ansible-playbook'


dpkg_unlock() {
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
    sudo dpkg --configure -a
}




alias he='heroku'
alias hc='heroku config'
alias hcs='heroku config:set'

alias hlw='heroku local web'




# autoenv
# source /usr/local/bin/activate.sh
# direnv
# eval "$(direnv hook zsh)"

alias sr='sudo service'
alias f8='flake8'


alias rmc='sudo rabbitmqctl '
alias rl='sudo rabbitmqctl list_queues name messages consumers'

rabbitmq_reset() {
    celery purge -f
    sudo rabbitmqctl stop_app
    sudo rabbitmqctl reset
    sudo rabbitmqctl start_app
}

# workon py35

export PYTHONDONTWRITEBYTECODE=1
alias pd='j py && ipy'
alias p2='wo py27'


alias rc=redis-cli



alias hip='http ipinfo.io'

alias ni='npm install '


alias clb='for remote in `git branch -r | grep -v /HEAD`; do git checkout --track $remote ; done'


alias watch='watch '
alias wt='watch -n1 '

alias ep='echo $PATH'
alias arduino='sudo ~/projects/vendor/arduino/arduino'
alias rdn=arduino

alias rmo='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM1 --upload '
alias rmz='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM0 --upload '

alias rmz='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM0 --upload '

alias rma='sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM* --upload '

alias ruz='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:uno --port /dev/ttyACM0 --upload '
alias ruu='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:uno --port /dev/ttyUSB0 --upload '
alias ruo='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:uno --port /dev/ttyACM1 --upload '
alias rua='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:uno --port /dev/ttyACM* --upload '

alias am='sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega'
alias amu='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM0 --upload master/master.ino'
alias asu='sudo pkill screen; sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM1 --upload slave_ultra/slave_ultra.ino'


alias pmz='sudo pkill screen; platformio ci --board=megaatmega2560 --project-option="upload_port=/dev/ttyACM0" --project-option="targets=upload"'
alias pmz='sudo pio ci --board=megaatmega2560 --project-option="lib_deps=LedControl" --project-option="targets=upload" --project-option="upload_port=/dev/ttyACM0"'


alias dfh='df -h'

spi() {
    s pk screen
    sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM0 --upload master/master.ino
    sudo ~/projects/vendor/arduino/arduino --board arduino:avr:mega --port /dev/ttyACM1 --upload slave_ultra/slave_ultra.ino
}


ams() {
    s pk screen
    sudo ~/projects/vendor/arduino/arduino --port /dev/ttyACM0 --board arduino:avr:mega --upload m/m.ino
    sudo ~/projects/vendor/arduino/arduino --port /dev/ttyACM1 --board arduino:avr:mega --upload s/s.ino
}


alias ob='python2 /home/chillaranand/projects/ocr/ocropy/ocropus-nlbin '
alias ops='python2 /home/chillaranand/projects/ocr/ocropy/ocropus-gpageseg '


alias sl='sar -q'
alias sq='sar -q'

alias tf='tail -f'


alias dnr='dotnet run'


free_port() {
    fuser -k $1/tcp
}
alias fp=free_port


reset_dns_resolver() {
    echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf > /dev/null
}
alias rdr=reset_dns_resolver


upload_to_arduino() {
    sudo pkill screen;
    ~/projects/vendor/arduino/arduino --port /dev/ttyACM* --board arduino:avr:mega:cpu=atmega2560 --upload $1
}

alias uta=upload_to_arduino
alias sm='sudo screen /dev/ttyACM0 '






alias psqlr='psql -h '$PSQL_HOST' -U '$PSQL_USER


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="/home/chillaranand/.cask/bin:$PATH"
export PATH="/home/chillaranand/projects/vendor/arduino:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.cask/bin:$PATH"
export PATH="$HOME/projects/eddie/ubuntu/bin:$PATH"
export PATH="$HOME/rr/prebuilts/sdk/tools:$PATH"
export PATH="$HOME/usr/bin:$PATH"
export PATH="/usr/local/bin:$PATH"



export NODEENV_HOME=$HOME/.nodeenvs
export MANPATH="/usr/local/man:$MANPATH"

export NIKOLA_MONO=true


# disable systemctl pager
export SYSTEMD_PAGER=''
export SYSTEMD_PAGER='cat'


# to build android from source
# export USE_CCACHE=1
# ~/android/lineage/prebuilts/misc/linux-x86/ccache/ccache -M 50G
export CCACHE_COMPRESS=1

export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# echo 'DHOST: '$DHOST


PATH="/home/chillaranand/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/chillaranand/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/chillaranand/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/chillaranand/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/chillaranand/perl5"; export PERL_MM_OPT;

export PATH=$PATH:/usr/local/go/bin

# [[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
source ~/Dropbox/tech/private.sh
# workon py36

source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zaw/zaw.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


alias nr='sudo service nginx restart'


reset_iptables() {
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F INPUT
sudo iptables -F OUTPUT
sudo iptables -F FORWARD
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GPG_TTY=$(tty)

export DJANGO_COLORS="light"

# . /media/chillar/ef9ada8f-2818-458d-b450-324a17c357fc/projects/sandbox/torch/install/bin/torch-activate


# alias gradle='~/projects/vendor/android-studio/gradle/gradle-3.2/bin/gradle'
alias androidstudio='~/projects/vendor/android-studio-ide-173.4819257-linux/android-studio/bin/studio.sh'

export PATH="/home/chillaranand/Downloads/android-ndk-r12b-linux-x86_64/android-ndk-r12b:$PATH"
export PATH="/Applications/calibre.app/Contents/console.app/Contents/MacOS/:$PATH"
export PATH="/usr/local/texlive/2018/bin/x86_64-darwin/:$PATH"


alias nds='androidstudio'

# export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre/bin/java
# export JAVA_HOME="/usr/lib/jvm/java-9-openjdk-amd64"

# export ANDROID_HOME="/usr/lib/android-sdk/"
# export ANDROID_HOME="/home/chillar/projects/vendor/android-sdk-linux/"
# export ANDROID_HOME="/home/chillar/projects/android/sdk/"
# export ANDROID_HOME="/home/chillar/projects/android/Android"
# export ANDROID_HOME="/home/chillar/projects/android"
# export ANDROID_HOME="/home/chillar/Android/Sdk/"
export ANDROID_HOME="/Users/curatech/Library/Android/Sdk/"
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export VAGRANT_NO_COLOR=True


gai() {
    ./gradlew assembleDebug
    ai -r app/build/outputs/apk/debug/app-debug.apk
        # adb shell am start -n com.foo.bar
}


source .env || true

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/chillar/google-cloud-sdk/path.zsh.inc' ]; then source '/home/chillar/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/home/chillar/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/chillar/google-cloud-sdk/completion.zsh.inc'; fi


# mac



rdb(){
    # brew services restart postgresql@9.6
    sleep 16;
    psql -c "drop database $1"
    psql -c "create database $1"
    psql -d $1 -f $2
}


alias bsl='brew services list'





nwe (){
    networksetup -setwebproxystate Wi-Fi on
    networksetup -setsecurewebproxystate Wi-Fi on
}

nwd (){
    networksetup -setwebproxystate Wi-Fi off
    networksetup -setsecurewebproxystate Wi-Fi off
}



alias edl='eb deploy --label `git rev-parse HEAD`'
alias es='eb ssh'

today=`date '+%Y_%m_%d__%H_%M_%S'`;


alias hdi='howdoi '
alias hdip='howdoi python '
alias hdis='howdoi shell '



# aptible

alias aca='aptible config --app'
alias ala='aptible logs --app'

alias asa='aptible ssh --app'

alias adt='aptible db:tunnel'
# alias adtp='aptible db:tunnel --type postgres'
alias adtp='aptible db:tunnel --port 55555'
alias adtm='aptible db:tunnel --type management'

alias asn='aptible ssh --app nh-prod-south'
alias asd='aptible ssh --app dia-prod-new-south'
alias asg='aptible ssh --app gastro-prod-south'
alias asp='aptible ssh --app pulmo-prod-south'

alias ara='aptible restart --app'



alias dkm='docker-machine'



alias os='openssl'
alias ov='openssl verify'


wol () {
    j library
    wo library
}

rcs () {
    j _server
    wo cura_server
    dr
}

km () {
    j kumbha
    . ~/.local/share/virtualenvs/cura_server/bin/activate
}


export COMPOSE_HTTP_TIMEOUT=120

export PATH="/Users/curatech/.crc/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


alias tm=tmuxinator
alias tms=tmuxinator start
alias tmx=tmuxinator stop

export PATH="/usr/local/Cellar/postgresql@9.6/9.6.17/bin:$PATH"

alias init='bash ~/projects/init/mac/init.sh'
alias mi='sh -c "$(curl https://raw.githubusercontent.com/ChillarAnand/init/master/mac/init.sh)"'


alias mst='minikube status'
alias sz='source ~/.zshrc'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias k=kubectl
# alias kd='kubectl --namespace=deis'
alias dk=docker
alias m=minikube
alias mk='minikube kubectl'


export PATH="/usr/local/opt/llvm/bin:$PATH"
export LLVM_CONFIG="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
# export PATH="/usr/local/opt/helm@2/bin:$PATH"
