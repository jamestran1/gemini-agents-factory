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
$geminiArgs = "--prompt-file `"$agentPromptPath`""

if ($Mock) {
    $msg = "Launched Gemini CLI session for project $ProjectId with agent $Agent (Command: $geminiExe $geminiArgs)"
    Write-Host $msg
    return $msg
}

Write-Host "Launching Gemini CLI for Project: $ProjectId, Agent: $Agent..."

# We must launch PowerShell and tell it to run the gemini.ps1 script.
# We also want to stay in the project directory.
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "Set-Location `"$projectRoot`" ; & `"$geminiExe`" $geminiArgs"

Write-Host "Session started."
