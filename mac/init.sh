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


# locate
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist


cd $config_dir


sh ${config_dir}'/terminal.sh'


rm ~/.zshrc
ln -s $config_dir'/zshrc.sh' ~/.zshrc


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


brew cask install pycharm google-chrome


# utils
brew install clean-me cowsay
brew cask install stretchly karabiner-elements
# brew cask install platypus HazeOver

cp $config_dir'/mac/space_control.json' ~/.config/karabiner/assets/complex_modifications/

# debookee_tools, Blackmagic Disk Speed Test
mas install 1110355801 425264550


# kindle
# brew cask install kindle

# adb
# brew cask install android-platform-tools

# ms
# brew cask install microsoft-office

# virtualbox
# brew cask install virtualbox

# network & cyber security tools
brew tap caffix/amass
brew install amass masscan nmap
brew cask install wireshark



echo "Successfully bootstrapped"
