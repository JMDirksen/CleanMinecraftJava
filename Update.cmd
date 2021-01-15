@echo off

:: Load config
setlocal
for /f %%a in (config.ini) do set %%a

:: Get version
for /f tokens^=3^,6^ delims^=^"^>^< %%a in ('curl -s https://www.minecraft.net/en-us/download/server/ ^| find "https://launcher.mojang.com"') do (
    set server_url=%%a
    set file_name=%%b
)
for /f "tokens=2,3,4 delims=." %%a in ("%file_name%") do set version=%%a.%%b.%%c

echo Latest version: %version%
if exist %file_name% (
    echo Already on latest version
    goto :eof
)

:: Download
echo Downloading new version: %file_name%
curl -s -o %file_name% %server_url%

:: Update
echo Stopping server...
call Stop.cmd
echo Updating server.jar
copy /y %file_name% server.jar >nul
echo Starting server...
start Start.cmd

:: Notify
call PushoverNotification.cmd "Clean Minecraft Java server updated to version: %version%"
