#!/bin/bash

# This script need to be execute each time server is starting (as soon as a new log file is created ...)
logFile="/srv/7d2d/7DaysToDieServer_Data/""$(ls -t /srv/7d2d/7DaysToDieServer_Data/ | grep "output_log" | head -n1)"
# Discord script source : https://github.com/fieu/discord.sh/tree/master
discordScript="/srv/scripts/discord.sh"
webhookUrl="YOUR_DISCORD_CHANNEL_WEBHOOK_URL_HERE"
joinSentence="joined the game"
leaveSentence="left the game"
deadSentence="died"

tail -f -n0 "$logFile" | while read line; 
    do
        echo "$line" | grep -q "joined the game" && \
      			playerName=$(echo "$line" | awk '{print $6}' | sed "s/'//g") && \
    			  echo "$playerName $joinSentence" && \
    			  bash $discordScript --webhook-url="$webhookUrl" --text "$playerName $joinSentence"
    		echo "$line" | grep -q "left the game" && \
            playerName=$(echo "$line" | awk '{print $6}' | sed "s/'//g") && \
            echo "$playerName $leaveSentence" && \
    			  bash $discordScript --webhook-url="$webhookUrl" --text "$playerName $leaveSentence"
    		echo "$line" | grep -q "Player '.*' died" && \
            playerName=$(echo "$line" | awk '{print $6}' | sed "s/'//g") && \
            echo "$playerName $deadSentence" && \
            bash $discordScript --webhook-url="$webhookUrl" --text "$playerName $deadSentence"
    done
exit 0
