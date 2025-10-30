<#
Install JetBrainsMono Nerd Font on Windows.
Usage (PowerShell run as admin recommended):
  .\install_fonts.ps1
#>

param()

$zipUrl = 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip'
$tempZip = Join-Path $env:TEMP 'jetbrains.zip'
$extractDir = Join-Path $env:TEMP 'jetbrains'

Write-Host "Downloading JetBrainsMono Nerd Font..."
Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip -UseBasicParsing

if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
Expand-Archive -Path $tempZip -DestinationPath $extractDir

# Use Shell.Application's Fonts folder CopyHere to install fonts
$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)

Get-ChildItem -Path $extractDir -Filter *.ttf -Recurse | ForEach-Object {
    $file = $_.FullName
    Write-Host "Installing $file"
    $fontsFolder.CopyHere($file)
}

Write-Host "Installed fonts. You may need to log out and log in for applications to pick them up." 

# cleanup
Remove-Item $tempZip -Force
# do not remove extractDir in case user wants to inspect

exit 0
