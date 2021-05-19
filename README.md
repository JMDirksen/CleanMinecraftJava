# CleanMinecraftJava

## Prerequisites

    sudo apt install -y git screen lynx openjdk-17-jre-headless

## Clone

    git clone https://github.com/JeftaDirksen/CleanMinecraftJava.git cleanmcjava
    cd cleanmcjava

## Download

    lynx -dump -listonly -nonumbers https://www.minecraft.net/en-us/download/server | grep server.jar | xargs wget -O server/server.jar

## Configure

    cp server.properties.template server/server.properties
    crontab crontab.template

## Start server

    ./start.sh

## Backup

    crontab -e
        SHELL=/bin/bash
        0 * * * * rsync -r --del --password-file=<(echo password) ~/cleanmcjava user@host::Backup/
