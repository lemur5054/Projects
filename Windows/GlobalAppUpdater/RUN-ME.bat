@echo off
title Update All Apps (Admin)

:: 1. Check if the script is running with Administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    :: Not admin. Relaunch this batch file as Administrator.
    powershell.exe -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: 2. We are now admin. Check if the PowerShell script exists.
if not exist "%~dp0update-all-apps.ps1" (
    echo ERROR: update-all-apps.ps1 was not found in:
    echo %~dp0
    echo.
    pause
    exit /b 1
)

:: 3. Run the PowerShell script as Administrator
echo Running update-all-apps.ps1 with Administrator privileges...
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0update-all-apps.ps1"

:: 4. Keep the window open so you can read the results
echo.
echo Update process finished.
pause