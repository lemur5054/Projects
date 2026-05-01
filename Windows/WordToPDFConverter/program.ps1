$word = New-Object -ComObject Word.Application
$word.Visible = $false

$folderPath = Join-Path -Path $PSScriptRoot -ChildPath "input"
$outputFolderPath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\Output"

# Ensure the output directory exists
if (-not (Test-Path -Path $outputFolderPath)) {
    New-Item -ItemType Directory -Path $outputFolderPath -Force | Out-Null
}

$files = Get-ChildItem -Path $folderPath -Filter *.docx
$totalFiles = $files.Count
$counter = 0

foreach ($file in $files) {
    $counter++
    
    # Calculate exact percentage completed
    [int]$percentComplete = ($counter / $totalFiles) * 100

    # Render the interactive progress bar
    Write-Progress -Activity "Converting Word Docs to PDF" `
                   -Status "Processing file $counter of $totalFiles" `
                   -PercentComplete $percentComplete `
                   -CurrentOperation "Now converting: $($file.Name)"

    $doc = $word.Documents.Open($file.FullName)
    $pdfFilename = [System.IO.Path]::ChangeExtension($file.Name, ".pdf")
    $outputPath = Join-Path -Path $outputFolderPath -ChildPath $pdfFilename
    
    $doc.SaveAs([String]$outputPath, [ref] 17)
    $doc.Close()
}

# Clear the progress bar after the loop finishes
Write-Progress -Activity "Converting Word Docs to PDF" -Completed

$word.Quit()
