# Gemini Agent Factory MCP Server
# Implements Model Context Protocol via JSON-RPC over stdio

$ProtocolVersion = "2024-11-05"

function Write-MCPResponse($Id, $Result) {
    $response = @{
        jsonrpc = "2.0"
        id = $Id
        result = $Result
    }
    $json = $response | ConvertTo-Json -Compress -Depth 10
    [Console]::Out.WriteLine($json)
}

function Write-MCPError($Id, $Code, $Message) {
    $response = @{
        jsonrpc = "2.0"
        id = $Id
        error = @{
            code = $Code
            message = $Message
        }
    }
    $json = $response | ConvertTo-Json -Compress -Depth 10
    [Console]::Out.WriteLine($json)
}

function List-Tools {
    return @{
        tools = @(
            @{
                name = "factory__add_project"
                description = "Add a new project to the factory manifest."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        projectId = @{ type = "string"; description = "Unique ID for the project." }
                        name = @{ type = "string"; description = "Display name for the project." }
                    }
                    required = @("projectId", "name")
                }
            }
        )
    }
}

# Main Loop
while ($line = [Console]::In.ReadLine()) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    
    try {
        $request = $line | ConvertFrom-Json
        $id = $request.id
        
        switch ($request.method) {
            "initialize" {
                Write-MCPResponse $id @{
                    protocolVersion = $ProtocolVersion
                    capabilities = @{}
                    serverInfo = @{ name = "gemini-agents-factory"; version = "1.0.0" }
                }
            }
            "tools/list" {
                Write-MCPResponse $id (List-Tools)
            }
            default {
                Write-MCPError $id -32601 "Method not found: $($request.method)"
            }
        }
    } catch {
        Write-MCPError $null -32700 "Parse error: $($_.Exception.Message)"
    }
}
