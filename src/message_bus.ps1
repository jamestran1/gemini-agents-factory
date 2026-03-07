param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Send", "Get")]
    [string]$Action,

    [string]$From,
    [string]$To,
    [string]$Message,
    [string]$ContextFile = "src/shared_context.json"
)

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
