# Windows App Updater (winget)

A simple, automated script suite to update all installed Windows applications using the Windows Package Manager (`winget`). It ensures the update process runs with the necessary Administrator privileges and bypasses execution policy restrictions.

##  Files Included
- **`update-apps-admin.bat`**: The entry point. A batch script that checks for Admin privileges, elevates itself if necessary, and launches the PowerShell script.
- **`update-all-apps.ps1`**: The core logic. A PowerShell script that checks for `winget` and executes the mass update command.

##  Prerequisites
- **Operating System**: Windows 10 or Windows 11.
- **App Installer**: You must have the latest version of the **App Installer** from the Microsoft Store, which includes the `winget` command-line tool.

##  How to Use
1. Download or create both `update-apps-admin.bat` and `update-all-apps.ps1`.
2. Place both files in the **same directory/folder**.
3. Double-click `update-apps-admin.bat`.
4. If prompted by User Account Control (UAC), click **Yes** to allow Administrator privileges.
5. A terminal window will open, fetch the latest package sources, and begin updating all your apps automatically.

---
