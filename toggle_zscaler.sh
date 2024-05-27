#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title toggle zscaler
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ☁️

# Documentation:
# @raycast.author chillaranand
# @raycast.authorURL https://avilpage.com/


# check if zscaler is running and toggle it on mac

if pgrep -x "Zscaler" > /dev/null
then
    # echo "Stopping Zscaler"
    osascript -e 'display notification "Stopping..." with title "ZScaler"' -e 'delay 1'
    find /Library/LaunchAgents -name '*zscaler*' -exec launchctl unload {} \;
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl unload {} \;
else
    osascript -e 'display notification "Starting..." with title "ZScaler"' -e 'delay 1'
    open -a /Applications/Zscaler/Zscaler.app --hide
    sudo find /Library/LaunchDaemons -name '*zscaler*' -exec launchctl load {} \;
    sudo find /Library/LaunchAgents -name '*zscaler*' -exec launchctl load {} \;
    # echo "Starting Zscaler"
fi
