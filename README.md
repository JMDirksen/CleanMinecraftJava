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
/gamerule keepInventory true
```

## Automate

```bash
crontab -e
  @reboot ~/cleanmcjava/start.sh
  0 0 * * * ~/cleanmcjava/countusers.sh
```

## Minecraft Stats

```bash
sudo apt install apache2
sudo nano /var/www/html/index.html
  <script>location.href='./minecraftstats';</script>
sudo git clone https://github.com/pdinklag/MinecraftStats.git /var/www/html/minecraftstats
sudo chown -R jefta:jefta /var/www/html/minecraftstats
mkdir /var/www/html/minecraftstats/config
nano /var/www/html/minecraftstats/config/config
  -s
  /home/jefta/cleanmcjava
crontab -e
  */5 * * * * cd /var/www/html/minecraftstats ; python3 update.py -c config >/dev/null
```
