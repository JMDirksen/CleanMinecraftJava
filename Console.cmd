@echo off

:: Load config
setlocal
for /f %%a in (config.ini) do set %%a

mcrcon.exe
