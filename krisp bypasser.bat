@echo off
:: Show the commands being executed
setlocal enabledelayedexpansion

:: Kill Discord process
echo Killing Discord process...
taskkill /IM Discord.exe /F
if %ERRORLEVEL% neq 0 (
    echo Failed to kill Discord.exe
    pause
    exit /b
)

:: Define path
set "base_path=C:\Users\iamt6\AppData\Local\Discord"
set "latest_version="

:: Find the latest version of Discord
echo Finding the latest version of Discord...
for /f "delims=" %%i in ('dir /b /ad %base_path%\app-*') do set "latest_version=%%i"
echo Latest version found: %latest_version%
if not defined latest_version (
    echo No Discord version found!
    pause
    exit /b
)

:: Navigate to discord_krisp directory in the latest version
set "krisp_path=%base_path%\%latest_version%\modules\discord_krisp-1\discord_krisp"
if not exist "%krisp_path%\index.js" (
    echo index.js not found!
    pause
    exit /b
)

:: Delete index.js
echo Deleting index.js in %krisp_path%...
del "%krisp_path%\index.js"
if %ERRORLEVEL% neq 0 (
    echo Failed to delete index.js
    pause
    exit /b
)

:: Reopen Discord
echo Reopening Discord...
start "" "%base_path%\%latest_version%\Discord.exe"
if %ERRORLEVEL% neq 0 (
    echo Failed to open Discord.exe
    pause
    exit /b
)

echo Script execution completed.
pause
