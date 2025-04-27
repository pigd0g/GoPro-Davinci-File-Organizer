# Use the current working directory
$directory = Get-Location

# Remove all *.THM files
Get-ChildItem -Path $directory -Filter "*.THM" | Remove-Item -Force

# Rename GL*.LRV to GX*.MOV
Get-ChildItem -Path $directory -Filter "GL*.LRV" | ForEach-Object {
  $newName = $_.Name -replace "^GL", "GX"
  $newName = $newName -replace "\.LRV$", ".MOV"
  Rename-Item -Path $_.FullName -NewName $newName
}

# Process GX*.MOV and GX*.MP4 files
Get-ChildItem -Path $directory -Filter "GX*.*" | ForEach-Object {
  $fileName = $_.BaseName
  $fileExtension = $_.Extension
  if ($fileName -match "^GX(\d{2})(.*)") {
    $prefix = [int]$matches[1]  # Cast to integer
    $restOfName = $matches[2]

    # Print the variables
    Write-Host "Processing File: $($_.Name)"
    # Write-Host "Prefix: $prefix"
    # Write-Host "Rest of Name: $restOfName"

    if ($prefix -gt 1) {
      # Compare numerically
      # Construct the new file name
      $newName = "GX01$restOfName-$prefix$fileExtension"
      Write-Host "Renaming File: $_.Name to $newName"
    }
    else {
      # Keep the original name for GX01 files
      $newName = $_.Name
    }

    # Rename the file if needed
    if ($_.Name -ne $newName) {
      Rename-Item -Path $_.FullName -NewName $newName
    }
  }
}

# Create a "proxy" directory if it doesn't exist
$proxyDir = Join-Path -Path $directory -ChildPath "proxy"
if (-not (Test-Path -Path $proxyDir)) {
  New-Item -Path $proxyDir -ItemType Directory | Out-Null
}

# Move all *.MOV files to the "proxy" directory
Get-ChildItem -Path $directory -Filter "*.MOV" | ForEach-Object {
  Move-Item -Path $_.FullName -Destination $proxyDir
}
