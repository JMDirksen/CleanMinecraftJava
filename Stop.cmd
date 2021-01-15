@echo off

:: Load config
setlocal
for /f %%a in (config.ini) do set %%a

echo 1 > mcstop.tmp
mcrcon.exe "function restart:initiate"
timeout /t 40
