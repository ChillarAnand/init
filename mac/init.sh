#! /bin/sh

set -x

project_name='init'
config_dir=${HOME}'/projects/'${project_name}

sh ${config_dir}'/mac/bootstrap.sh'


# locate
# sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist


cd $config_dir


sh ${config_dir}'/terminal.sh'


rm ~/.zshrc
ln -s $config_dir'/zshrc.sh' ~/.zshrc


if [ -f ~/Dropbox/tech/init/zsh_history ]; then
    cp .zsh_history .zsh_history-$(date "+%Y.%m.%d-%H.%M.%S").bkp
    rm ~/.zsh_history
    ln -s ~/Dropbox/tech/init/zsh_history ~/.zsh_history
fi


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


installed_packages=($(brew list; brew cask list))
# brew_list=($(brew list))
# brew_cask_list=($(brew cask list))

function brew_install() {
    for i in "${installed_packages[@]}"
    do
        echo "$i"
        if [ "$i" = "$1" ] ; then
            echo "Package $1 already installed"
            return
        fi
    done

    if [ "$2" ];
    then
        brew cask install $1
    else
        brew install $1
    fi
}

brew_install pycharm cask


# utils
brew_install clean-me
brew_install cowsay
brew_install karabiner-elements cask
brew_install stretchly cask
brew_install watch
brew_install foxitreader
brew_install mucommander


# brew cask install platypus HazeOver

cp $config_dir'/mac/space_control.json' ~/.config/karabiner/assets/complex_modifications/

# debookee_tools, Blackmagic Disk Speed Test
brew install mas
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
# brew tap caffix/amass
# brew install amass masscan nmap
# brew cask install wireshark



echo "Successfully bootstrapped"
