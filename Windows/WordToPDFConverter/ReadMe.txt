Word to PDF Batch Converter
A lightweight script to automate the batch conversion of Microsoft Word documents (.docx) to PDF format using PowerShell and a supporting Windows Batch file launcher.
🚀 Features
One-Click Execution: Run the batch file to instantly process all documents.
Native Processing: Uses your local Microsoft Word application for perfect formatting retention.
Visual Feedback: Live percentage progress bar with a completed/total counter.
Automated Setup: Automatically generates the output folder if it doesn't already exist. 
📁 File Structure
Place your files in a folder structured exactly like this:
text
📂 Project Folder/
├── 📄 run.bat (The file you double-click)
├── 📄 program.ps1 (The PowerShell script handling the logic)
└── 📂 input/ (Folder containing your Word .docx files)
Use code with caution.
⚙️ How It Works
The script reads all files ending in .docx from the local input directory.
It quietly opens Microsoft Word in the background.
It converts each file and deposits the finished PDFs directly into your Windows Downloads\Output\ directory.
It shuts down the background Word instance automatically upon completion.
🛠️ Prerequisites
OS: Windows 10 or Windows 11.
Software: Microsoft Word must be installed on the machine.
Permissions: No administrative rights are required to run this script. 
⚠️ Known Behaviors
Password Protected Files: If a document requires a password to open, the script will pause and prompt you via a Microsoft Word pop-up window.
Performance: Processing speed scales directly with the physical size and complexity of your documents.
Would you like to add a troubleshooting section to this file in case execution policies block the script on certain machines?
