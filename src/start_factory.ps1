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
# We also set the window title and print a welcome message.
$launchCommand = "`$Host.UI.RawUI.WindowTitle = 'FACTORY: $Agent - $ProjectId' ; Clear-Host ; Write-Host '========================================' -ForegroundColor Cyan ; Write-Host '  GEMINI AGENT FACTORY: $Agent' -ForegroundColor Cyan ; Write-Host '  Project: $ProjectId' -ForegroundColor Cyan ; Write-Host '========================================' -ForegroundColor Cyan ; `$env:GEMINI_SYSTEM_MD = '$agentPromptPath' ; Set-Location '$projectRoot' ; & '$geminiExe'"

Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", $launchCommand

Write-Host "Session started."
