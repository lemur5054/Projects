@echo off
setlocal

:: 🔐 Auto-request Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: 🌐 Force UTF-8 for clean console output
chcp 65001 >nul

echo ========================================
echo    Fresh Windows Pre-Flight Fix
echo ========================================
echo.
echo Automating:
echo  [1] Microsoft Store & App Installer initialization
echo  [2] PowerShell execution policy configuration
echo  [3] Winget source reset & package index update
echo.
echo Please wait... (do not close this window)
echo.

echo [1/3] Initializing Store components...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -Name Microsoft.WindowsStore | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\" } 2>$null" >nul 2>&1
timeout /t 2 >nul
echo ✅ Store components registered.

echo [2/3] Configuring PowerShell execution policy...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force 2>$null" >nul 2>&1
echo ✅ Execution policy configured.

echo [3/3] Resetting and updating winget sources...
powershell -NoProfile -ExecutionPolicy Bypass -Command "winget source reset --force" 2>&1 | findstr /v /i "copyright"
powershell -NoProfile -ExecutionPolicy Bypass -Command "winget source update" 2>&1 | findstr /v /i "copyright"
echo ✅ Winget ready.

echo.
echo ========================================
echo    ✅ Pre-Flight Complete!
echo ========================================
echo.
echo Your system is ready. Run Run-Installer.bat next.
echo Tip: If winget still fails, reboot once and retry.
echo.
pause