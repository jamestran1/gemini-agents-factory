# Test MCP Server core handler
$mcpPath = ".\src\mcp_server.ps1"

if (-not (Test-Path $mcpPath)) {
    Write-Host "FAIL: src/mcp_server.ps1 not found."
    exit 1
}

# Helper to run server with input and capture first line of output
function Invoke-MCPServer($InputJson) {
    $inputFile = [System.IO.Path]::GetTempFileName()
    $outputFile = [System.IO.Path]::GetTempFileName()
    
    $InputJson | Out-File $inputFile -Encoding utf8
    
    # We use cmd /c to handle redirection properly in Start-Process if needed, 
    # but let's try a simpler way using a background job or just direct execution.
    $script = {
        param($m, $i, $o)
        Get-Content $i | powershell.exe -NoProfile -File $m | Out-File $o -Encoding utf8
    }
    
    $job = Start-Job -ScriptBlock $script -ArgumentList @((Resolve-Path $mcpPath).Path, $inputFile, $outputFile)
    
    if (-not (Wait-Job $job -Timeout 2)) {
        Stop-Job $job
    }
    
    $output = Get-Content $outputFile -Raw
    
    Remove-Item $inputFile, $outputFile -ErrorAction SilentlyContinue
    return $output
}

$initReq = @{ jsonrpc = "2.0"; id = 1; method = "initialize"; params = @{ protocolVersion = "2024-11-05" } } | ConvertTo-Json -Compress
$resp = Invoke-MCPServer $initReq

if ($resp -match "protocolVersion" -and $resp -match "2024-11-05") {
    Write-Host "PASS: initialize response received."
} else {
    Write-Host "FAIL: initialize response incorrect. Got: $resp"
    exit 1
}

$listReq = @{ jsonrpc = "2.0"; id = 2; method = "tools/list"; params = @{} } | ConvertTo-Json -Compress
$resp = Invoke-MCPServer $listReq

if ($resp -match "factory__add_project") {
    Write-Host "PASS: tools/list response received."
} else {
    Write-Host "FAIL: tools/list response incorrect. Got: $resp"
    exit 1
}
