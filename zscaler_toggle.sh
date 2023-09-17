#! /bin/sh

# check if zscaler is running and toggle it on mac

if pgrep -x "Zscaler" > /dev/null
then
    echo "Killing Zscaler"
    killall Zscaler
    find /Library/LaunchAgents -name '*zscaler*' -exec launchctl unload {} \;
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl unload {} \;
else
    echo "Starting Zscaler"
    pkill -f 'Google Chrome'
    open -a /Applications/Zscaler/Zscaler.app --hide
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl load {} \;
fi