# Test Start Factory Script (Mocked)
$startPath = ".\src\start_factory.ps1"

# Test: Launch session without actual execution (dry run / mock)
$result = & $startPath -ProjectId "test_proj" -Agent "master" -Mock
if ($result -match "Launched Gemini CLI session for project test_proj with agent master") {
    Write-Host "PASS: StartFactory (Mock) successful."
} else {
    Write-Host "FAIL: StartFactory (Mock) failed. Result: $result"
    exit 1
}
