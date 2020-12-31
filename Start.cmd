@echo off
title Clean Minecraft Java
:loop
start /abovenormal /wait /b java -Xms4G -Xmx4G -jar server.jar nogui
timeout /t 30
goto loop
