#!/bin/bash
cd "$(dirname "$0")"
cd server
while true
do
  java -Xms6G -Xmx6G -jar server.jar
  [ -f stop ] && { rm stop;  exit; }
  echo 'Press Ctrl-C to stop'
  sleep 5
done
