#!/bin/bash

# Send a message to a Telegram bot. Useful for notifications based on other scripts.
# Usage: $ telegram.sh "Message here"

MESSAGE=$1
CHATID=###
APIKEY=###

MESSAGE="${MESSAGE// /+}"
wget -O /dev/null --post-data="chat_id=$CHATID&text=$MESSAGE" https://api.telegram.org/bot$APIKEY/sendMessage
