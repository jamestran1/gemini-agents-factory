# Test Extension Manifest
$manifestFile = "gemini-extension.json"

if (Test-Path $manifestFile) {
    try {
        $content = Get-Content $manifestFile -Raw | ConvertFrom-Json
        
        # Validate mandatory fields
        if (-not $content.name) { Write-Host "FAIL: 'name' field missing."; exit 1 }
        if (-not $content.version) { Write-Host "FAIL: 'version' field missing."; exit 1 }
        if (-not $content.description) { Write-Host "FAIL: 'description' field missing."; exit 1 }
        
        # Check specific values
        if ($content.name -ne "gemini-agents-factory") { Write-Host "FAIL: Incorrect extension name '$($content.name)'."; exit 1 }
        
        # Validate MCP server registration
        if (-not $content.mcpServers) { Write-Host "FAIL: 'mcpServers' field missing."; exit 1 }
        if (-not $content.mcpServers.factory) { Write-Host "FAIL: 'factory' MCP server not registered."; exit 1 }
        
        Write-Host "PASS: gemini-extension.json is valid and includes MCP registration."
    } catch {
        Write-Host "FAIL: gemini-extension.json is not valid JSON. Error: $($_.Exception.Message)"
        exit 1
    }
} else {
    Write-Host "FAIL: gemini-extension.json not found."
    exit 1
}
