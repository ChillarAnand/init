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


cd $config_dir


sh ${config_dir}'/terminal.sh'


rm ~/.zshrc
ln -s $config_dir'/cli/zshrc.sh' ~/.zshrc


# set screenshots folder
defaults write com.apple.screencapture location ~/Pictures



# editors

if [ ! -d ~/.emacs.d/ ]; then
    brew cask install emacs
    ln -s ${config_dir}'/emacs' ~/.emacs.d/
    touch ~/.emacs.d/custom.el
    touch ~/.emacs.d/private.el
    # ln -s ~/Dropbox/tech/private.el ~/.emacs.d/.private.el
fi


sh ${config_dir}'/python.sh'


# breaks
# brew cask install stretchly
brew cask install time-out


brew cask install pycharm

# kindle
brew cask install kindle


# browser
brew cask install google-chrome


# adb
# brew cask install android-platform-tools


# ms
# brew cask install microsoft-office


# virtualbox
# brew cask install virtualbox


# network & cyber security tools
# ./network.sh

# brew cask install HazeOver
# brew cask install platypus


# brew install cowsay nmap antigen mas

# utils
brew cask install karabiner-elements
cp $config_dir'/mac/space_control.json' ~/.config/karabiner/assets/complex_modifications/


# Blackmagic Disk Speed Test
# mas install 425264550


# locate
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

echo "Successfully bootstrapped"
