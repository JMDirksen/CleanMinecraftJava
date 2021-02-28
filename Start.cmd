@echo off
title Clean Minecraft Java
if exist mcstop.tmp del mcstop.tmp
:loop
start /abovenormal /wait /b java -Xmx6G -XX:+UseG1GC -jar server.jar nogui
if not exist mcstop.tmp goto loop
del mcstop.tmp
