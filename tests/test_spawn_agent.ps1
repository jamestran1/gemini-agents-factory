# Test Parallel Task Spawning (Mocked)
$spawnPath = ".\src\spawn_agent.ps1"

# Test: Spawn background agent without actual execution
$result = & $spawnPath -ProjectId "parallel_test" -Agent "software_engineer" -Mock
if ($result -match "Spawned background Gemini CLI session for project parallel_test with agent software_engineer") {
    Write-Host "PASS: SpawnAgent (Mock) successful."
} else {
    Write-Host "FAIL: SpawnAgent (Mock) failed. Result: $result"
    exit 1
}
