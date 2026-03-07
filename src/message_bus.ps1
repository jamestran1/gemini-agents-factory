param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Send", "Get")]
    [string]$Action,

    [string]$From,
    [string]$To,
    [string]$Message,
    [string]$ContextFile = "shared_context.json"
)

# Anchor the default filename to the project root if no specific directory is provided
if (-not ([System.IO.Path]::IsPathRooted($ContextFile)) -and -not ($ContextFile -match '[\\/]')) {
    $projectRoot = Split-Path $PSScriptRoot -Parent
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
