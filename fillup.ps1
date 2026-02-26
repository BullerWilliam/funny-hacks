# List of safe, user-writable root folders
$roots = @(
    "$env:USERPROFILE\Downloads",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Pictures",
    "$env:USERPROFILE\Music",
    "$env:USERPROFILE\Videos"
)

$maxSizeGB = 100000000
$fileSizeMB = 100

$maxBytes = $maxSizeGB * 1GB
$currentBytes = 0

function New-RandomName {
    return -join ((48..57)+(65..90)+(97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_})
}

function Get-RandomFolder {
    $root = Get-Random $roots
    $depth = Get-Random -Minimum 1 -Maximum 4
    $path = $root

    for ($i = 0; $i -lt $depth; $i++) {
        $folder = New-RandomName
        $path = Join-Path $path $folder
    }

    New-Item -ItemType Directory -Force -Path $path | Out-Null
    return $path
}

while ($currentBytes -lt $maxBytes) {
    $folder = Get-RandomFolder
    $fileName = (New-RandomName) + ".bin"
    $filePath = Join-Path $folder $fileName

    fsutil file createnew $filePath ($fileSizeMB * 1MB)

    $currentBytes += ($fileSizeMB * 1MB)
}

Write-Host "Done. Filled approximately $($currentBytes / 1GB) GB."
