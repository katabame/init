$ErrorActionPreference = "Stop"
$FilePath = "$Env:TEMP\init_katabame.cmd"
if (Test-Path $FilePath) { Remove-Item $FilePath }
Invoke-WebRequest -Uri https://init.kataba.me/win/cmd -OutFile $FilePath
. $FilePath
if ($LASTEXITCODE -eq 0) { exit } else { if (Test-Path $FilePath) { Remove-Item $FilePath } }
