#!/bin/bash
cd "$(dirname "$0")"
touch "server/stop"
screen -S "cleanmcjava" -p 0 -X stuff "stop^M"
while screen -list | grep -q "cleanmcjava"
do
    sleep 1
done
