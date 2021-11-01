# CleanMinecraftJava

## Prerequisites

    sudo apt install -y git jq cron screen openjdk-18-jre-headless apache2

## Setup/Configure/Update/Start

    git clone https://github.com/JeftaDirksen/CleanMinecraftJava.git cleanmcjava
    cd cleanmcjava
    cp server.properties.template server/server.properties
    ./update.sh

## MinecraftStats

    cd ~
    git clone https://github.com/pdinklag/MinecraftStats.git mcstats
    cd mcstats
    ./makeconfig.py -s ../cleanmcjava/server --inactive-days 30 --min-playtime 15 > config.json

    sudo nano /etc/apache2/sites-available/000-default.conf
      DocumentRoot /home/jefta/mcstats
      <Directory />
        Require all granted
      </Directory>
    chmod +x ~
    sudo service apache2 reload

## Automation

    crontab crontab.template
