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
```

## Automate

- Create Scheduled Task running `Start.cmd` on user login and make user auto login on boot
