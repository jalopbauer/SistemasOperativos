#!/bin/sh
if [ $# -ne 2 ]; then
    echo "Usage: $0 <string> <number>"
    exit 1
fi
while true
do
  echo "$1"
  sleep $2
done
