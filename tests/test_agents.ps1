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

# Test Designer UI/UX Agent Existence
if (Test-Path "src/agents/designer.md") {
    Write-Host "PASS: src/agents/designer.md exists."
} else {
    Write-Host "FAIL: src/agents/designer.md not found."
    exit 1
}

# Test Designer Prompt Content
$content = Get-Content "src/agents/designer.md" -Raw
if ($content -match "Designer" -and $content.ToLower() -match "visual") {
    Write-Host "PASS: Designer prompt contains expected content."
} else {
    Write-Host "FAIL: Designer prompt content is incorrect."
    exit 1
}

# Test Project Manager Agent Existence
if (Test-Path "src/agents/project_manager.md") {
    Write-Host "PASS: src/agents/project_manager.md exists."
} else {
    Write-Host "FAIL: src/agents/project_manager.md not found."
    exit 1
}

# Test Project Manager Prompt Content
$content = Get-Content "src/agents/project_manager.md" -Raw
if ($content -match "Project Manager" -and $content.ToLower() -match "tasks" -and $content -match "trello_service.ps1") {
    Write-Host "PASS: Project Manager prompt contains expected content and Trello instructions."
} else {
    Write-Host "FAIL: Project Manager prompt content is incorrect or missing Trello instructions."
    exit 1
}

# Test Software Engineer Agent Existence
if (Test-Path "src/agents/software_engineer.md") {
    Write-Host "PASS: src/agents/software_engineer.md exists."
} else {
    Write-Host "FAIL: src/agents/software_engineer.md not found."
    exit 1
}

# Test Software Engineer Prompt Content
$content = Get-Content "src/agents/software_engineer.md" -Raw
if ($content -match "Software Engineer" -and $content.ToLower() -match "implementation") {
    Write-Host "PASS: Software Engineer prompt contains expected content."
} else {
    Write-Host "FAIL: Software Engineer prompt content is incorrect."
    exit 1
}

# Test QA Agent Existence
if (Test-Path "src/agents/qa.md") {
    Write-Host "PASS: src/agents/qa.md exists."
} else {
    Write-Host "FAIL: src/agents/qa.md not found."
    exit 1
}

# Test QA Prompt Content
$content = Get-Content "src/agents/qa.md" -Raw
if ($content -match "QA" -and $content.ToLower() -match "verification") {
    Write-Host "PASS: QA prompt contains expected content."
} else {
    Write-Host "FAIL: QA prompt content is incorrect."
    exit 1
}
