# Test Multi-Project Message Bus
$busPath = ".\src\message_bus.ps1"
$contextDir = "tests\contexts"

if (-not (Test-Path $contextDir)) { New-Item -ItemType Directory $contextDir }

$projectA = "project_a"
$projectB = "project_b"
$fileA = Join-Path $contextDir "shared_context_$projectA.json"
$fileB = Join-Path $contextDir "shared_context_$projectB.json"

if (Test-Path $fileA) { Remove-Item $fileA }
if (Test-Path $fileB) { Remove-Item $fileB }

# Test: Send Message to Project A using ProjectId
& $busPath -Action Send -From "PO" -To "PM" -Message "Msg A" -ProjectId $projectA
# Test: Send Message to Project B using ProjectId
& $busPath -Action Send -From "PO" -To "PM" -Message "Msg B" -ProjectId $projectB

$projectRoot = Split-Path (Split-Path $busPath -Parent) -Parent
$realFileA = Join-Path $projectRoot "shared_context_$projectA.json"
$realFileB = Join-Path $projectRoot "shared_context_$projectB.json"

$messagesA = @(Get-Content $realFileA -Raw | ConvertFrom-Json)
$messagesB = @(Get-Content $realFileB -Raw | ConvertFrom-Json)

if ($messagesA.Count -eq 1 -and $messagesA[0].Message -eq "Msg A") {
    Write-Host "PASS: Project A isolation via ProjectId successful."
} else {
    Write-Host "FAIL: Project A isolation via ProjectId failed."
    exit 1
}

if ($messagesB.Count -eq 1 -and $messagesB[0].Message -eq "Msg B") {
    Write-Host "PASS: Project B isolation via ProjectId successful."
} else {
    Write-Host "FAIL: Project B isolation via ProjectId failed."
    exit 1
}

# Cleanup
if (Test-Path $realFileA) { Remove-Item $realFileA }
if (Test-Path $realFileB) { Remove-Item $realFileB }
