# Test Product Owner Agent Existence
if (Test-Path "src/agents/product_owner.md") {
    Write-Host "PASS: src/agents/product_owner.md exists."
} else {
    Write-Host "FAIL: src/agents/product_owner.md not found."
    exit 1
}

# Test Product Owner Prompt Content
$content = Get-Content "src/agents/product_owner.md" -Raw
if ($content -match "Product Owner" -and $content.ToLower() -match "requirements") {
    Write-Host "PASS: Product Owner prompt contains expected content."
} else {
    Write-Host "FAIL: Product Owner prompt content is incorrect."
    exit 1
}
