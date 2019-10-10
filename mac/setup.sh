#! /bin/sh

set -x


xcode-select --install


# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


project_name='platform'

if [ ! -d '~/projects/'${project_name} ]; then
    cd
    mkdir -p projects
    cd projects
    git clone 'https://github.com/chillaranand/'${project_name}
fi


config_dir=${HOME}'/projects/'${project_name}
cd $config_dir

bootstrap_script=${config_dir}'/mac/bootstrap_terminal.sh'
sh $bootstrap_script


# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures


# utils
brew install wget


# breaks
# brew cask install stretchly
brew cask install timeout


# editors
brew cask install emacs
if [ ! -d ~/.emacs.d/ ]; then
    ln -s ${config_dir}'/emacs' ~/.emacs.d/
    touch ~/.emacs.d/custom.el
    touch ~/.emacs.d/private.el
    # ln -s ~/Dropbox/tech/private.el ~/.emacs.d/.private.el
fi


# browser
brew cask install google-chrome



# adb
# brew cask install android-platform-tools


# oh my zsh
# emacs


# ms
# brew cask install microsoft-office


# virtualbox
# brew cask install virtualbox


# cyber security
# brew install masscan
# brew tap caffix/amass
# brew install amass
# brew cask install wireshark
# brew install mas

# brew cask install HazeOver


# brew cask install platypus


echo "Successfully bootstrapped"
