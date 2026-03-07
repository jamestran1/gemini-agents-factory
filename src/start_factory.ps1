param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectId,

    [Parameter(Mandatory=$true)]
    [string]$Agent,

    [switch]$Mock
)

$projectRoot = Split-Path $PSScriptRoot -Parent
$agentPromptPath = Join-Path $projectRoot "src\agents\$Agent.md"

if (-not (Test-Path $agentPromptPath)) {
    Write-Error "Agent prompt file not found: $agentPromptPath"
    exit 1
}

# The gemini command is a PowerShell script (C:\nvm4w\nodejs\gemini.ps1)
$geminiExe = "C:\nvm4w\nodejs\gemini.ps1"

if ($Mock) {
    $msg = "Launched Gemini CLI session for project $ProjectId with agent $Agent (using GEMINI_SYSTEM_MD=$agentPromptPath)"
    Write-Host $msg
    return $msg
}

Write-Host "Launching Gemini CLI for Project: $ProjectId, Agent: $Agent..."

# We set the GEMINI_SYSTEM_MD environment variable to the agent's prompt file.
# Then we launch gemini in a new window.
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "`$env:GEMINI_SYSTEM_MD = `"$agentPromptPath`" ; Set-Location `"$projectRoot`" ; & `"$geminiExe`""

Write-Host "Session started."
