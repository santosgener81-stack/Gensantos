$src = 'C:\Users\gener\joshua-portfolio'
$dest = 'C:\Users\gener\gener-portfolio.zip'
if (Test-Path $dest) { Remove-Item $dest -Force }
Compress-Archive -Path (Join-Path $src '*') -DestinationPath $dest
Write-Host "ZIP created: $dest"
