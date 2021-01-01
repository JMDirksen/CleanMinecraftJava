# CleanMinecraftJava

## Setup

### On server

- Install Java (64-bit) java.com
- Clone CleanMinecraftJava repository
- Download latest server.jar from https://www.minecraft.net/en-us/download/server/
- Run Start.cmd

### In game

```minecraft
/gamemode creative
/tp 0 100 0
/setworldspawn
/gamerule spawnRadius 500
```

## Automate

- Create Scheduled Task running `Start.cmd` on user login and make user auto login on boot
- Create Scheduled Task running `Count.cmd` every 5 minutes
- Create Scheduled Task running `powershell -file UserStats.ps1` every 5 minutes
