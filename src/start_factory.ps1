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

# Launch Gemini CLI. 
# We use Start-Process with gemini directly to avoid the 'PowerShell' window feel where possible.
# If 'gemini' is not a direct executable but a script/alias, we might need powershell -c.

$geminiCommand = "gemini"
$args = "--prompt-file `"$agentPromptPath`""

if ($Mock) {
    $msg = "Launched Gemini CLI session for project $ProjectId with agent $Agent (Command: $geminiCommand $args)"
    Write-Host $msg
    return $msg
}

Write-Host "Launching Gemini CLI for Project: $ProjectId, Agent: $Agent..."

# Using powershell to launch ensures paths and environment variables are inherited correctly
# but we execute gemini immediately.
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "$geminiCommand $args"

Write-Host "Session started."
