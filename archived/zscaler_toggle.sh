#! /bin/sh

# check if zscaler is running and toggle it on mac

if pgrep -x "Zscaler" > /dev/null
then
    osascript -e 'display notification "Stopping..." with title "ZScaler"' -e 'delay 1'
    sudo killall Zscaler
    sudo pkill -f ZscalerTunnel
    sudo pkill -f ZscalerService
    find /Library/LaunchAgents -name '*zscaler*' -exec launchctl unload {} \;
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl unload {} \;
else
    osascript -e 'display notification "Starting..." with title "ZScaler"' -e 'delay 1'
    # pgrep 'Google Chrome' | xargs kill -9
    # pgrep Tailscale | xargs kill -9
    # pgrep Vivaldi | xargs kill -9
    # echo "Starting Zscaler"
    # pkill -f 'Google Chrome'
    open -a /Applications/Zscaler/Zscaler.app --hide
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl load {} \;
fi
