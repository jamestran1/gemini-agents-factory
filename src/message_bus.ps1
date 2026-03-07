param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Send", "Get")]
    [string]$Action,

    [string]$From,
    [string]$To,
    [string]$Message,
    [string]$ProjectId,
    [string]$ContextFile
)

$scriptDir = $PSScriptRoot
$projectRoot = Split-Path $scriptDir -Parent

# When installed as an extension, $env:GEMINI_EXTENSION_PATH might be available.
# We ensure we are always working relative to the scripts folder or the provided ContextFile.
if ($env:GEMINI_EXTENSION_PATH) {
    $projectRoot = $env:GEMINI_EXTENSION_PATH
}

if ($ProjectId) {
    $ContextFile = Join-Path $projectRoot "shared_context_$ProjectId.json"
} elseif (-not $ContextFile) {
    $ContextFile = Join-Path $projectRoot "shared_context.json"
}

# Anchor the filename if it's relative and not already resolved
if (-not ([System.IO.Path]::IsPathRooted($ContextFile))) {
    $ContextFile = Join-Path $projectRoot $ContextFile
}

if ($Action -eq "Send") {
    $newMessage = @{
        Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        From = $From
        To = $To
        Message = $Message
    }

    if (Test-Path $ContextFile) {
        $messages = @(Get-Content $ContextFile -Raw | ConvertFrom-Json)
        $messages += $newMessage
    } else {
        $messages = @($newMessage)
    }

    $messages | ConvertTo-Json | Out-File $ContextFile
} elseif ($Action -eq "Get") {
    if (Test-Path $ContextFile) {
        $messages = @(Get-Content $ContextFile -Raw | ConvertFrom-Json)
        if ($To) {
            return @($messages | Where-Object { $_.To -eq $To })
        } else {
            return $messages
        }
    } else {
        return @()
    }
}
