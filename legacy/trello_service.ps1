param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("FetchBoard", "CreateTask")]
    [string]$Action,

    [string]$BoardId,
    [string]$ListId,
    [string]$Name,
    [string]$Description,
    [switch]$Mock
)

if ($Mock) {
    if ($Action -eq "FetchBoard") {
        return @{ id = $BoardId; name = "Mock Board" }
    } elseif ($Action -eq "CreateTask") {
        return @{ id = "mock_task_123"; name = $Name; desc = $Description }
    }
}

$key = $env:TRELLO_API_KEY
$token = $env:TRELLO_TOKEN

if (-not $key -or -not $token) {
    Write-Error "TRELLO_API_KEY and TRELLO_TOKEN environment variables must be set for real API calls."
    exit 1
}

$baseUrl = "https://api.trello.com/1"
$authParams = "key=$key&token=$token"

if ($Action -eq "FetchBoard") {
    $url = "$baseUrl/boards/$BoardId`?$authParams"
    return Invoke-RestMethod -Uri $url -Method Get
} elseif ($Action -eq "CreateTask") {
    $url = "$baseUrl/cards`?$authParams"
    $body = @{
        idList = $ListId
        name = $Name
        desc = $Description
    }
    return Invoke-RestMethod -Uri $url -Method Post -Body $body
}
