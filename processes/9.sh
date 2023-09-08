#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $0 <string>"
    exit 1
fi

ps aux | grep $1 | awk '{print $2}' | uniq -u | xargs -n1 kill -9 
