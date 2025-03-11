@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

setlocal enabledelayedexpansion

rem Get the current user's profile directory
set "userProfile=%UserProfile%"
set "baseDir=%userProfile%\AppData\Local\Discord"
set "latestVersionDir="

rem Find the most recent version directory
for /d %%D in ("%baseDir%\app-*") do (
    set "currentVersionDir=%%~fD"
    if "!currentVersionDir!" gtr "!latestVersionDir!" (
        set "latestVersionDir=!currentVersionDir!"
    )
)
echo Most recent version directory: %latestVersionDir%

rem Navigate to the discord_krisp directory
set "targetDir=%latestVersionDir%\modules\discord_krisp-1\discord_krisp"
echo Target directory: %targetDir%

rem Check if target directory exists and delete contents
if exist "%targetDir%" (
    echo Deleting all contents in %targetDir%
    del /f /q "%targetDir%\*"
    echo.
    echo.
    echo =====================================================
    echo.
    echo.
    echo  #########    ##########   #########    ##########
    echo  ##      ##   ##      ##   ##      ##   ##
    echo  ##      ##   ##      ##   ##      ##   ##
    echo  ##      ##   ##########   ##########   ##########
    echo  ##      ##   ##           ##      ##           ##
    echo  ##      ##   ##           ##      ##           ##
    echo  #########    ##           ##      ##   ##########
    echo.
    echo =====================================================
    echo  ##########   ##            ##########   #########
    echo  ##      ##   ##            ##      ##   ##      ##
    echo  ##      ##   ##            ##      ##   ##      ##
    echo  ##########   ##            ##      ##   ##      ##
    echo  ##           ##            ##      ##   ##      ##
    echo  ##           ##            ##      ##   ##      ##
    echo  ##           ##########    ##########   ##########
    echo.
    echo =====================================================
    echo.

    echo Ony's method: Successfully unpatched krisp noise suppression!
) else (
    echo Directory not found: %targetDir% to fix error open the offcial discordsetup.exe make sure discord is FULLY CLOSED then run setup
)

echo.
set /p closeDiscord=Would you like to close Discord? RECOMMENDED (y/n):

if /i "!closeDiscord!" == "y" (
    taskkill /f /im discord.exe
    echo Discord has been closed.
)

endlocal
pause
