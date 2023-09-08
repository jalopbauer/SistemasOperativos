#!/bin/sh
PORT=$1
PROCESS_ID=`lsof -i :$PORT | tail -1 | awk '{print $2}'`
if [ -z ${PROCESS_ID+x} ]
  then 
  echo "No process in port $PORT"
  else 
  echo -n "Press enter if you want to kill process $PROCESS_ID in port $PORT: " 
  read KEYPRESS
  if [ "$KEYPRESS" = '' ]
    then kill $PROCESS_ID
  fi
fi