@echo off
echo Starting Backup of Database: %1

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set dt=%%c-%%a-%%b)
For /f "tokens=1-4 delims=:." %%a in ('echo %time%') do (set tm=%%a%%b%%c%%d)
set bkupfilename=%1 %dt% %tm%.bak
echo Backing up to file: %bkupfilename%

"C:\Program Files\MySQL\MySQL Server 5.0\bin\mysqldump" %1 --routines --databases garc -u root -pgarc@somca > "c:/backup/%bkupfilename%"

echo Backup Complete!
pause
echo on
