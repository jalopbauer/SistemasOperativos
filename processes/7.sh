#!/bin/sh
./4.sh $1 $2 &
PID=$!

renice -n 19 -p $PID
sleep 20
renice -n 5 -p $PID

read -p "Presiona ENTER para matar el proceso."
kill -9 $PID