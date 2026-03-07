# Test Message Bus
$busPath = ".\src\message_bus.ps1"
$contextFile = "tests\shared_context.json"

if (Test-Path $contextFile) { Remove-Item $contextFile }

# Test: Send Message
& $busPath -Action Send -From "PO" -To "PM" -Message "Define features." -ContextFile $contextFile
$messages = @(Get-Content $contextFile -Raw | ConvertFrom-Json)
if ($messages.Count -eq 1 -and $messages[0].From -eq "PO" -and $messages[0].Message -eq "Define features.") {
    Write-Host "PASS: SendMessage successful."
} else {
    Write-Host "FAIL: SendMessage failed. Count=$($messages.Count)"
    exit 1
}

# Test: Get Messages
$result = @(& $busPath -Action Get -To "PM" -ContextFile $contextFile)
if ($result.Count -eq 1 -and $result[0].From -eq "PO") {
    Write-Host "PASS: GetMessages successful."
} else {
    Write-Host "FAIL: GetMessages failed. Count=$($result.Count)"
    exit 1
}

if (Test-Path $contextFile) { Remove-Item $contextFile }
