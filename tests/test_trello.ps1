# Test Trello Service (Mocked)
$trelloPath = ".\src\trello_service.ps1"

# Mock Mode: Test Fetching a Board
$board = & $trelloPath -Action FetchBoard -BoardId "mock_board_id" -Mock
if ($board.name -eq "Mock Board") {
    Write-Host "PASS: FetchBoard (Mock) successful."
} else {
    Write-Host "FAIL: FetchBoard (Mock) failed."
    exit 1
}

# Mock Mode: Test Creating a Task
$task = & $trelloPath -Action CreateTask -BoardId "mock_board_id" -Name "Test Task" -Mock
if ($task.name -eq "Test Task" -and $task.id -match "mock_task") {
    Write-Host "PASS: CreateTask (Mock) successful."
} else {
    Write-Host "FAIL: CreateTask (Mock) failed."
    exit 1
}
