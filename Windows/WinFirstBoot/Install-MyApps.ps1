[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 🔐 Administrator Check
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[ERROR] Please run this script as Administrator!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

$LogPath = "$env:USERPROFILE\Desktop\AppInstallLog.txt"
"=== App Installation Started: $(Get-Date) ===" | Out-File -FilePath $LogPath -Append

# 🔧 Fix winget sources on fresh Windows
Write-Host "Initializing winget package sources..." -ForegroundColor Cyan
winget source reset --force 2>&1 | Out-Null
winget source update 2>&1 | Out-Null
Start-Sleep -Seconds 3

# App List
$Apps = @(
    "Microsoft.EdgeWebView2Runtime",
    "Microsoft.VCRedist.2015+.x64",
    "Discord.Discord.PTB",
    "Microsoft.VisualStudioCode",
    "Mozilla.Firefox",
    "Notepad++.Notepad++",
    "Spotify.Spotify",
    "7zip.7zip",
    "Brave.Brave",
    "Google.Chrome",
    "Rufus.Rufus",
    "Valve.Steam",
    "VideoLAN.VLC",
    "RARLab.WinRAR",
    "OBSProject.OBSStudio",
    "WiseCleaner.WiseProgramUninstaller",
    "WinDirStat.WinDirStat",
    "Ollama.Ollama"
)
# 🚀 Install Loop (Shows progress, auto-accepts agreements, limits interaction)
foreach ($App in $Apps) {
    Write-Host "`n[INSTALLING] $App" -ForegroundColor Cyan
    Write-Host "--------------------------------------------------" -ForegroundColor DarkGray

    # Run winget directly to stream real-time progress
    # --silent removed so you see download/install progress
    # --force + --accept-* auto-handles prompts and partial states
    & winget install --id $App --force --accept-package-agreements --accept-source-agreements --source winget

    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Write-Host "[SUCCESS] $App" -ForegroundColor Green
        "SUCCESS: $App | $(Get-Date)" | Out-File -FilePath $LogPath -Append
    } else {
        Write-Host "[FAILED] $App (Exit Code: $exitCode)" -ForegroundColor Red
        "FAILED: $App (Code: $exitCode) | $(Get-Date)" | Out-File -FilePath $LogPath -Append
    }
    Write-Host "--------------------------------------------------`n" -ForegroundColor DarkGray
}

# 🤖 Ollama + Qwen Setup with Fallback
$OllamaPath = "$env:LOCALAPPDATA\Programs\Ollama\ollama.exe"
$SelectedModel = $null

if (Test-Path $OllamaPath) {
    Write-Host "`n[AI SETUP] Initializing Ollama service..." -ForegroundColor Cyan
    Start-Process -FilePath $OllamaPath -WindowStyle Hidden
    Start-Sleep -Seconds 5

    $ModelOptions = @("qwen3.5:4b", "qwen3.5:1.7b")
    foreach ($Model in $ModelOptions) {
        Write-Host "Downloading model: $Model ..." -ForegroundColor Cyan
        & $OllamaPath pull $Model 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[SUCCESS] Model ready: $Model" -ForegroundColor Green
            $SelectedModel = $Model
            break
        }
    }

    if ($SelectedModel) {
        Write-Host "[READY] Run your AI with: ollama run $SelectedModel" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] Model download failed. Run manually: ollama pull qwen3.5:4b" -ForegroundColor Yellow
    }
} else {
    Write-Host "[WARNING] Ollama executable not found at expected path." -ForegroundColor Yellow
}

# ⬆️ Auto-Update All Installed Apps
Write-Host "`n[UPDATING] Checking for app updates..." -ForegroundColor Cyan
winget upgrade --all --silent --accept-package-agreements --accept-source-agreements 2>&1 | Out-Null
Write-Host "[SUCCESS] Auto-update complete." -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Green
Write-Host " ALL INSTALLATIONS COMPLETE" -ForegroundColor Green
Write-Host " Check $LogPath for detailed results" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green
Read-Host "Press Enter to close"