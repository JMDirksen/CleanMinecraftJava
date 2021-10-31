#!/bin/bash
cd "$(dirname "$0")"
echo "Counting down... (30 sec.)"
screen -S "cleanmcjava" -p 0 -X stuff "say Server is restarting in 30 seconds^M"
sleep 20
screen -S "cleanmcjava" -p 0 -X stuff "say Server is restarting in 10 seconds^M"
sleep 5
screen -S "cleanmcjava" -p 0 -X stuff "say Server is restarting in 5...^M"
sleep 2
screen -S "cleanmcjava" -p 0 -X stuff "say Server is restarting in 3...^M"
sleep 1
screen -S "cleanmcjava" -p 0 -X stuff "say Server is restarting in 2...^M"
sleep 1
screen -S "cleanmcjava" -p 0 -X stuff "say Server is restarting in 1...^M"
sleep 1
screen -S "cleanmcjava" -p 0 -X stuff "stop^M"
echo "Restarting!"
