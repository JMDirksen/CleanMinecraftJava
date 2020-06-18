# CleanMinecraftJava

## Setup

### On server

```bash
sudo apt install default-jre-headless
git clone https://github.com/JeftaDirksen/CleanMinecraftJava.git cleanmcjava
cd cleanmcjava
wget https://launcher.mojang.com/.../server.jar
```

### In game

```minecraft
/gamemode creative
/tp 0 100 0
/setworldspawn
```

## Automate

```bash
  @reboot ~/cleanmcjava/start.sh
  0 0 * * * ~/cleanmcjava/countusers.sh
```
