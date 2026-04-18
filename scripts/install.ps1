#Requires -Version 5.1
<#
.SYNOPSIS
  Installs git-aliases-for-windows into %LOCALAPPDATA% and wires CMD + PowerShell.

.DESCRIPTION
  Copies cmd\aliases.cmd and powershell\GitAliases.ps1 to:
    %LOCALAPPDATA%\git-aliases-for-windows\
  Sets HKCU Command Processor AutoRun (REG_EXPAND_SZ) for CMD.
  Appends a marked block to the current host PowerShell profile ($PROFILE).
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot
$CmdSrc = Join-Path $RepoRoot 'cmd\aliases.cmd'
$PsSrc = Join-Path $RepoRoot 'powershell\GitAliases.ps1'

if (-not (Test-Path -LiteralPath $CmdSrc)) {
  throw "Missing $CmdSrc. Expected repo layout: cmd\ and powershell\ next to the scripts\ folder."
}
if (-not (Test-Path -LiteralPath $PsSrc)) {
  throw "Missing $PsSrc. Expected repo layout: cmd\ and powershell\ next to the scripts\ folder."
}

$InstallRoot = Join-Path $env:LOCALAPPDATA 'git-aliases-for-windows'
$CmdDst = Join-Path $InstallRoot 'cmd\aliases.cmd'
$PsDst = Join-Path $InstallRoot 'powershell\GitAliases.ps1'

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $CmdDst) | Out-Null
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $PsDst) | Out-Null

Copy-Item -LiteralPath $CmdSrc -Destination $CmdDst -Force
Copy-Item -LiteralPath $PsSrc -Destination $PsDst -Force

$autoRunValue = '%LOCALAPPDATA%\git-aliases-for-windows\cmd\aliases.cmd'
& reg.exe add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d $autoRunValue /f | Out-Null
if ($LASTEXITCODE -ne 0) {
  throw "reg.exe add failed with exit code $LASTEXITCODE"
}

$profileBlock = @'
# git-aliases-for-windows BEGIN
$_gitAliasesForWindowsPs1 = Join-Path $env:LOCALAPPDATA 'git-aliases-for-windows\powershell\GitAliases.ps1'
if (Test-Path -LiteralPath $_gitAliasesForWindowsPs1) {
  . $_gitAliasesForWindowsPs1
}
# git-aliases-for-windows END
'@

$profileDir = Split-Path -Parent $PROFILE
if (-not (Test-Path -LiteralPath $profileDir)) {
  New-Item -ItemType Directory -Force -Path $profileDir | Out-Null
}

$existing = ''
if (Test-Path -LiteralPath $PROFILE) {
  $existing = Get-Content -LiteralPath $PROFILE -Raw
}

if ($existing -match '(?m)^# git-aliases-for-windows BEGIN') {
  $pattern = '(?ms)^# git-aliases-for-windows BEGIN\r?\n.*?^# git-aliases-for-windows END\r?\n?'
  $updated = [regex]::Replace($existing, $pattern, $profileBlock.TrimEnd() + "`r`n")
} else {
  if ([string]::IsNullOrWhiteSpace($existing)) {
    $updated = $profileBlock.TrimEnd() + "`r`n"
  } else {
    $updated = $existing.TrimEnd() + "`r`n`r`n" + $profileBlock.TrimEnd() + "`r`n"
  }
}

Set-Content -LiteralPath $PROFILE -Value $updated -Encoding utf8

Write-Host "Installed to $InstallRoot"
Write-Host "CMD AutoRun set for new Command Prompt windows."
Write-Host "PowerShell profile updated: $PROFILE"
Write-Host "Open a new CMD or PowerShell tab to load aliases."
