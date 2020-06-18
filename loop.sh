#!/bin/bash
cd "$(dirname "$0")"

while true
do
  java -Xms16G -Xmx16G -jar server.jar
  echo 'Press Ctrl-C to stop'
  sleep 30
done
