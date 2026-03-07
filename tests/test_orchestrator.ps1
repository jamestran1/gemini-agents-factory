# Test Orchestrator Routing
$testCases = @(
    @{ Prompt = "We need to build a tip calculator."; Expected = "Product Owner" },
    @{ Prompt = "Design the layout for the calculator."; Expected = "Designer" },
    @{ Prompt = "Break down the features into tasks."; Expected = "Project Manager" },
    @{ Prompt = "Implement the calculator logic in Python."; Expected = "Software Engineer" },
    @{ Prompt = "Verify that the calculator works correctly."; Expected = "QA" }
)

foreach ($test in $testCases) {
    $result = .\src\orchestrator.ps1 -Prompt $test.Prompt
    if ($result -match $test.Expected) {
        Write-Host "PASS: Prompt '$($test.Prompt)' routed to $($test.Expected)."
    } else {
        Write-Host "FAIL: Prompt '$($test.Prompt)' expected $($test.Expected), but got '$result'."
        exit 1
    }
}
