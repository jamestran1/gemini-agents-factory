param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectId,

    [Parameter(Mandatory=$true)]
    [string]$Agent,

    [switch]$Mock
)

$scriptDir = $PSScriptRoot
$projectRoot = Split-Path $scriptDir -Parent
if ($env:GEMINI_EXTENSION_PATH) {
    $projectRoot = $env:GEMINI_EXTENSION_PATH
}

$agentPromptPath = Join-Path $projectRoot "agents\$Agent.md"

if (-not (Test-Path $agentPromptPath)) {
    Write-Error "Agent prompt file not found: $agentPromptPath"
    exit 1
}

# The gemini command is a PowerShell script (C:\nvm4w\nodejs\gemini.ps1)
$geminiExe = "C:\nvm4w\nodejs\gemini.ps1"

if ($Mock) {
    $msg = "Spawned background Gemini CLI session for project $ProjectId with agent $Agent (using GEMINI_SYSTEM_MD=$agentPromptPath)"
    Write-Host $msg
    return $msg
}

Write-Host "Spawning background agent: $Agent for project $ProjectId..."

# Use Start-Process with -WindowStyle Minimized for 'background' feel
Start-Process powershell.exe -ArgumentList "-NoProfile", "-Command", "`$env:GEMINI_SYSTEM_MD = `"$agentPromptPath`" ; Set-Location `"$projectRoot`" ; & `"$geminiExe`"" -WindowStyle Minimized

Write-Host "Agent spawned in background (minimized window)."
