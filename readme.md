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
        0 * * * * rsync -rt --del --password-file=<(echo password) ~/cleanmcjava user@host::Backup/

## MinecraftStats

    git clone https://github.com/pdinklag/MinecraftStats.git
    cd MinecraftStats
    ./makeconfig.py -s ../cleanmcjava/server --inactive-days 30 --min-playtime 15 > config.json
    crontab -e
      */5 * * * * cd ~/MinecraftStats && python3 update.py config.json

    sudo apt install apache2
    sudo nano /etc/apache2/sites-available/000-default.conf
      DocumentRoot /home/jefta/MinecraftStats
      <Directory />
        Require all granted
      </Directory>
    sudo service apache2 reload
    chmod +x ~
