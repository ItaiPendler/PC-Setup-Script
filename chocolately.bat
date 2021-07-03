@echo off
CLS
set currentpath=%cd%
echo "Starting..."
echo "Script must run in admin mode"
ECHO.
:MENU
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO FIRST TIME press 2!
ECHO ...............................................
ECHO.
ECHO 1 - Download Apps
ECHO 2 - Download Chocolatey
ECHO 3 - Set Configurations
ECHO 3 - Update Apps
ECHO 4 - EXIT
ECHO.


SET /P M=Type 1, 2, 3, 4 or 5 then press ENTER:
IF %M%==1 GOTO GEN
IF %M%==2 GOTO FIR
IF %M%==3 GOTO CON
IF %M%==4 GOTO UPG
IF %M%==5 GOTO EOF

REM developer tools
:FIR
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n allowGlobalConfirmation
choco upgrade chocolatey
ECHO ...............................................
ECHO A RESTART OF THE BATCH FILE IS MAYBE NECESSARY!!
ECHO ...............................................
ECHO ...............................................
GOTO MENU

:UPG
choco upgrade all
GOTO MENU

:GEN
REM basic apps
choco install defaultapps.config
GOTO CON

:CON
REM setup configuration
git config --global core.hooksPath hooks
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br branch
git config --global alias.cm commit
REM git config --global alias.ls log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative
git config --global alias.ll "log --graph --oneline --decorate --all"




SET /P NAME=Type Your Name then press ENTER:
git config --global user.name "%NAME%"
SET /P EMAIL=Type Your Email press ENTER:
git config --global user.email "%EMAIL%"

REM neta says hi
REM vs code extentions
code --install-extension CPR-Development-ExtensionPack-0.0.1.vsix
GOTO MENU

:EOF