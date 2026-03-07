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

# Use 'gemini' as the executable.
# For background tasks, we can use --non-interactive if supported,
# or simply launch in a minimized window / hidden process.
$command = "gemini --prompt-file `"$agentPromptPath`""

if ($Mock) {
    $msg = "Spawned background Gemini CLI session for project $ProjectId with agent $Agent (Command: $command)"
    Write-Host $msg
    return $msg
}

Write-Host "Spawning background agent: $Agent for project $ProjectId..."

# Use Start-Process with -WindowStyle Hidden or Minimized for 'background' feel
Start-Process powershell.exe -ArgumentList "-NoProfile", "-Command", "$command" -WindowStyle Minimized

Write-Host "Agent spawned in background (minimized window)."
