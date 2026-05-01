@echo off
setlocal

:: 🔐 Auto-request Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: 🌐 Force UTF-8 for compatibility
chcp 65001 >nul

echo ========================================
echo    Fresh Windows App Installer
echo ========================================
echo.

:: Get script directory
set "SCRIPT_DIR=%~dp0"

:: Run PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Install-MyApps.ps1"

echo.
echo ========================================
echo    Installation Finished
echo ========================================
pause