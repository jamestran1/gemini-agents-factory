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

# Construct the Gemini CLI command.
# Using 'gemini' as the executable (assuming it's in path).
# Passing the system prompt and potentially setting up an environment for the project ID.
$command = "gemini --prompt-file `"$agentPromptPath`""

if ($Mock) {
    $msg = "Launched Gemini CLI session for project $ProjectId with agent $Agent (Command: $command)"
    Write-Host $msg
    return $msg
}

Write-Host "Launching Gemini CLI for Project: $ProjectId, Agent: $Agent..."

# Use Start-Process to launch in a new window (supporting 'multiple session tabs' feel)
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "$command"

Write-Host "Session started."
