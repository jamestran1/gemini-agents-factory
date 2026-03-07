# Test Master Orchestrator Agent Existence
if (Test-Path "src/agents/master.md") {
    Write-Host "PASS: src/agents/master.md exists."
} else {
    Write-Host "FAIL: src/agents/master.md not found."
    exit 1
}

# Test Master Orchestrator Prompt Content
$content = Get-Content "src/agents/master.md" -Raw
if ($content -match "Master Orchestrator" -and $content.ToLower() -match "orchestrate|delegate") {
    Write-Host "PASS: Master Orchestrator prompt contains expected content."
} else {
    Write-Host "FAIL: Master Orchestrator prompt content is incorrect."
    exit 1
}
