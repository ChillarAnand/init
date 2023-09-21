#! /bin/sh

# check if zscaler is running and toggle it on mac

if pgrep -x "Zscaler" > /dev/null
then
    echo "Killing Zscaler"
    killall Zscaler
    find /Library/LaunchAgents -name '*zscaler*' -exec launchctl unload {} \;
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl unload {} \;
else
    pgrep 'Google Chrome' | xargs kill -9
    pgrep Tailscale | xargs kill -9
    echo "Starting Zscaler"
    # pkill -f 'Google Chrome'
    open -a /Applications/Zscaler/Zscaler.app --hide
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl load {} \;
fi
