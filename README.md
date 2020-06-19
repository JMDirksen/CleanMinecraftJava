# CleanMinecraftJava

## Setup

### On server

```bash
sudo apt install default-jre-headless
git clone https://github.com/JeftaDirksen/CleanMinecraftJava.git cleanmcjava
cd cleanmcjava
# Get server url: https://www.minecraft.net/en-us/download/server/
wget https://launcher.mojang.com/.../server.jar
# Optional: level-seed=??? and server-port=????? in server.properties
chmod -w server.properties
./start
screen -r cleanmcjava
```

### In game

```minecraft
/gamemode creative
/tp 0 100 0
/setworldspawn
/gamerule spawnRadius 100
```

## Automate

```bash
crontab -e
  @reboot ~/cleanmcjava/start.sh
  0 0 * * * ~/cleanmcjava/countusers.sh
```
