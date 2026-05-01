# Fresh Windows Automated Installer

## Overview
A lightweight, script-based toolkit for fresh Windows 10/11 installations. Automatically prepares the system, fixes package manager dependencies, and installs essential apps + sets up a local AI environment (Ollama + Qwen 3.5) with real-time progress tracking and detailed logging.

## Included Files
| File | Purpose |
|------|---------|
| `FreshPC-PreFlight.bat` | Initializes Store components, configures PowerShell execution policy, resets & updates `winget` sources |
| `Install-MyApps.ps1` | Core installer: runs dependency-first app installs, streams progress, sets up Ollama + Qwen AI model |
| `Run-Installer.bat` | Safe launcher: requests Admin rights, forces UTF-8, and runs the PowerShell script with zero policy conflicts |

## Prerequisites
- Windows 10 (version 1809 or newer) or Windows 11
- Administrator account access
- Active internet connection
- ~5GB free disk space (apps + AI model)
- **Recommended:** Run Windows Update & reboot once before starting

## How to Use (Step-by-Step)
1. **Copy the folder** to your fresh Windows PC (Desktop or Documents works best)
2. **Run Pre-Flight:**  
   Double-click `FreshPC-PreFlight.bat` → Click **Yes** on the UAC prompt → Wait ~15 seconds → Close when done
3. **Run Installer:**  
   Double-click `Run-Installer.bat` → Click **Yes** on UAC → Watch real-time progress for each app
4. **Verify Results:**  
   Check `C:\Users\[YourName]\Desktop\AppInstallLog.txt` for success/fail timestamps
5. **Launch AI Chat:**  
   Open PowerShell or Command Prompt and run:  
   ```bash
   ollama run qwen3.5:4b

   ## What Gets Installed

| Category | Apps |
|---|---|
| **Runtimes** | Edge WebView2, VC++ Redistributable 2015+ |
| **Browsers** | Mozilla Firefox, Google Chrome, Brave |
| **Utilities** | 7-Zip, WinRAR, Rufus, Wise Program Uninstaller, WinDirStat, Notepad++, VS Code |
| **Media** | Spotify, VLC Media Player, OBS Studio |
| **Gaming/Chat** | Discord PTB, Steam |
| **AI** | Ollama + Qwen 3.5 (4B model, auto-fallback to 1.7B) |

## Customization Guide

Edit `Install-MyApps.ps1` in Notepad to adjust:

- **Add/Remove Apps:** Modify the `$Apps` array. Use `winget search "AppName"` in PowerShell to find official IDs.
- **Change AI Model:** Edit this line:
  ```powershell












  Troubleshooting
Issue
Fix
winget not recognized
Open Microsoft Store once or run Windows Update, then reboot
Exit Code -1978335146
PreFlight fixes this; ensure EdgeWebView2Runtime installs first (already ordered in script)
Scripts blocked by policy
FreshPC-PreFlight.bat handles this automatically; always run as Admin
Ollama executable not found
Wait 10 seconds after install, or restart your terminal/PowerShell
Slow downloads
winget uses Microsoft CDN; check internet or run during off-peak hours
Logging
All results are saved to: Desktop\AppInstallLog.txt
Includes timestamps, success/fail status, winget exit codes, and AI setup status
Safe to delete after verifying installations
Open in Notepad to review or share for debugging
Security & Notes
All apps pulled from official winget repositories (Microsoft-curated)
No third-party downloaders, adware, or bundled software
Scripts are fully transparent, readable, and modify nothing outside standard install paths
AI model downloads directly from official Ollama CDN (~2.5GB)
Run at your own discretion. Always review scripts before executing on critical systems
For enterprise/managed PCs: Group Policies may override execution settings; this toolkit respects those boundaries
Support & Updates
Test in a VM or secondary machine before deploying to primary devices
Keep winget updated via winget upgrade --all
AI models can be swapped anytime: ollama pull qwen3.5:8b or ollama rm qwen3.5:4b
Built for speed, transparency, and zero-click fresh installs. 
