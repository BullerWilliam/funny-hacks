$targetFolder = "C:\DummyFill"
$maxSizeGB = 100000000   # Change this to how much space you want to fill
$fileSizeMB = 10

New-Item -ItemType Directory -Force -Path $targetFolder | Out-Null

$maxBytes = $maxSizeGB * 1GB
$currentBytes = 0
$fileIndex = 1

while ($currentBytes -lt $maxBytes) {
    $filePath = Join-Path $targetFolder ("dummy_" + $fileIndex + ".bin")
    fsutil file createnew $filePath ($fileSizeMB * 1MB)
    $currentBytes += ($fileSizeMB * 1MB)
    $fileIndex++
}

Write-Host "Done. Created $($fileIndex - 1) files."
