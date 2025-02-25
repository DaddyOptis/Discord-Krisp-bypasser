@echo off
setlocal

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting administrator privileges...
    goto UACPrompt
) else (
    goto main
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b

:main
    echo Killing Discord processes...
    taskkill /f /im discord.exe >nul 2>&1

    set "github_url=https://raw.githubusercontent.com/DaddyOptis/Discord-Krisp-bypasser/refs/heads/main/index.js"
    set "appdata_dir=%localappdata%\Discord"

    echo Finding latest Discord version...

    for /d %%a in ("%appdata_dir%\app-*") do (
        set "discord_version=%%~nxa"
    )

    if not defined discord_version (
        echo Error: Discord installation not found.
        pause
        exit /b 1
    )

    set "module_dir=%appdata_dir%\%discord_version%\modules\discord_krisp-1"

    if not exist "%module_dir%" (
        echo Error: discord_krisp-1 module not found.
        pause
        exit /b 1
    )

    echo Downloading index.js...
    curl -s -o "%module_dir%\index.js" "%github_url%"

    if errorlevel 1 (
        echo Error: Failed to download index.js.
        pause
        exit /b 1
    )

    echo index.js replaced successfully.
    pause
    exit /b 0