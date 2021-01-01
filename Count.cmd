@echo off
setlocal

:: Config
set datafile=Count.ini
set port=25565
set tempfile=Count.tmp

:: Load stats
set avg15min=0
set avghour=0
set avgday=0
set avgweek=0
set avgmonth=0
if exist %datafile% for /f %%a in (%datafile%) do set %%a

:: Count connections
netstat -n | find ":%port% " | find /c "ESTABLISHED" > %tempfile%
set /p count=<%tempfile%
del %tempfile%

:: Calculate averages (x10000)
set /a avg15min=(%avg15min%*2+(%count%*10000))/3
set /a avghour=(%avghour%*11+(%count%*10000))/12
set /a avgday=(%avgday%*287+(%count%*10000))/288
set /a avgweek=(%avgweek%*2015+(%count%*10000))/2016
set /a avgmonth=(%avgmonth%*8639+(%count%*10000))/8640

:: Store stats
echo avg15min=%avg15min% > %datafile%
echo avghour=%avghour% >> %datafile%
echo avgday=%avgday% >> %datafile%
echo avgweek=%avgweek% >> %datafile%
echo avgmonth=%avgmonth% >> %datafile%
