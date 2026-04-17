#Requires -Version 5.1
<#
.SYNOPSIS
  Removes git-aliases-for-windows integration (CMD AutoRun, profile block, optional files).

.PARAMETER RemoveFiles
  Also deletes %LOCALAPPDATA%\git-aliases-for-windows\.
#>
[CmdletBinding()]
param(
  [switch] $RemoveFiles
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

& reg.exe delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f 2>$null | Out-Null

if (Test-Path -LiteralPath $PROFILE) {
  $existing = Get-Content -LiteralPath $PROFILE -Raw
  $pattern = '(?ms)^# git-aliases-for-windows BEGIN\r?\n.*?^# git-aliases-for-windows END\r?\n?'
  if ($existing -match $pattern) {
    $updated = ([regex]::Replace($existing, $pattern, '')).TrimEnd() + "`r`n"
    if ([string]::IsNullOrWhiteSpace($updated.Trim())) {
      Remove-Item -LiteralPath $PROFILE -Force
    } else {
      Set-Content -LiteralPath $PROFILE -Value $updated -Encoding utf8
    }
  }
}

if ($RemoveFiles) {
  $installRoot = Join-Path $env:LOCALAPPDATA 'git-aliases-for-windows'
  if (Test-Path -LiteralPath $installRoot) {
    Remove-Item -LiteralPath $installRoot -Recurse -Force
  }
}

Write-Host "Removed Command Processor AutoRun (if present) and profile block (if present)."
if ($RemoveFiles) {
  Write-Host "Removed install folder under LOCALAPPDATA."
}
