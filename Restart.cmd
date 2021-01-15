@echo off

:: Load config
setlocal
for /f %%a in (config.ini) do set %%a

mcrcon.exe "function restart:initiate"
timeout /t 30
