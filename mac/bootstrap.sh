#! /bin/sh

set -x


xcode-select --install


if [ ! -f /usr/local/bin/brew ]; then
    # install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


project_name='init'
config_dir=${HOME}'/projects/'${project_name}


if [ ! -d ~/projects/${project_name} ]; then
    cd
    mkdir -p projects
    cd projects
    git clone 'https://github.com/chillaranand/'${project_name}
else
    cd $config_dir
    git pull origin master
fi
