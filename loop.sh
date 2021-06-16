#!/bin/bash
cd "$(dirname "$0")"
cd server
while true
do
  java -Xms2G -Xmx2G -jar server.jar
  echo 'Press Ctrl-C to stop'
  sleep 5
done
