# Gemini Agent Factory MCP Server
# Implements Model Context Protocol via JSON-RPC over stdio

$ProtocolVersion = "2024-11-05"
$ProgressPreference = 'SilentlyContinue'
$LogFile = Join-Path $PSScriptRoot "mcp_server.log"

function Write-Log($Message) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "[$timestamp] $Message" | Out-File $LogFile -Append -Encoding utf8
}

function Write-MCPResponse($Id, $Result) {
    $response = @{
        jsonrpc = "2.0"
        id = $Id
        result = $Result
    }
    $json = $response | ConvertTo-Json -Compress -Depth 10
    [Console]::Out.WriteLine($json)
    Write-Log "OUT: $json"
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
    Write-Log "ERR: $json"
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
            },
            @{
                name = "factory__list_projects"
                description = "List all projects in the factory manifest."
                inputSchema = @{ type = "object"; properties = @{} }
            },
            @{
                name = "factory__send_message"
                description = "Send a message to the project's shared context bus."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        projectId = @{ type = "string"; description = "Project ID." }
                        from = @{ type = "string"; description = "Sender agent role." }
                        to = @{ type = "string"; description = "Recipient agent role." }
                        message = @{ type = "string"; description = "Message content." }
                    }
                    required = @("projectId", "from", "to", "message")
                }
            },
            @{
                name = "factory__get_messages"
                description = "Retrieve messages for an agent from the context bus."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        projectId = @{ type = "string"; description = "Project ID." }
                        to = @{ type = "string"; description = "Recipient agent role filter." }
                    }
                    required = @("projectId", "to")
                }
            },
            @{
                name = "factory__start_session"
                description = "Launch a foreground Master Orchestrator session for a project."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        projectId = @{ type = "string"; description = "Project ID." }
                    }
                    required = @("projectId")
                }
            },
            @{
                name = "factory__spawn_agent"
                description = "Spawn a background agent task for a project."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        projectId = @{ type = "string"; description = "Project ID." }
                        agent = @{ type = "string"; description = "Agent role to spawn (e.g. software_engineer)." }
                    }
                    required = @("projectId", "agent")
                }
            },
            @{
                name = "factory__trello_fetch"
                description = "Fetch a Trello board's details."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        boardId = @{ type = "string"; description = "Trello Board ID." }
                    }
                    required = @("boardId")
                }
            },
            @{
                name = "factory__trello_create"
                description = "Create a new card (task) on a Trello list."
                inputSchema = @{
                    type = "object"
                    properties = @{
                        listId = @{ type = "string"; description = "Trello List ID." }
                        name = @{ type = "string"; description = "Card title." }
                        description = @{ type = "string"; description = "Card description." }
                    }
                    required = @("listId", "name")
                }
            }
        )
    }
}

function Call-Tool($Name, $Arguments) {
    $scriptDir = $PSScriptRoot
    
    switch ($Name) {
        "factory__add_project" {
            $scriptPath = Join-Path $scriptDir "project_state.ps1"
            $output = & $scriptPath -Action Add -ProjectId $Arguments.projectId -Name $Arguments.name 2>&1
            return @{ content = @(@{ type = "text"; text = "$output" }) }
        }
        "factory__list_projects" {
            $scriptPath = Join-Path $scriptDir "project_state.ps1"
            $output = & $scriptPath -Action List 2>&1
            $text = $output | ConvertTo-Json
            return @{ content = @(@{ type = "text"; text = "$text" }) }
        }
        "factory__send_message" {
            $scriptPath = Join-Path $scriptDir "message_bus.ps1"
            $output = & $scriptPath -Action Send -ProjectId $Arguments.projectId -From $Arguments.from -To $Arguments.to -Message $Arguments.message 2>&1
            return @{ content = @(@{ type = "text"; text = "$output" }) }
        }
        "factory__get_messages" {
            $scriptPath = Join-Path $scriptDir "message_bus.ps1"
            $output = & $scriptPath -Action Get -ProjectId $Arguments.projectId -To $Arguments.to 2>&1
            $text = $output | ConvertTo-Json
            return @{ content = @(@{ type = "text"; text = "$text" }) }
        }
        "factory__start_session" {
            $scriptPath = Join-Path $scriptDir "start_factory.ps1"
            $output = & $scriptPath -ProjectId $Arguments.projectId -Agent "master" 2>&1
            return @{ content = @(@{ type = "text"; text = "$output" }) }
        }
        "factory__spawn_agent" {
            $scriptPath = Join-Path $scriptDir "spawn_agent.ps1"
            $output = & $scriptPath -ProjectId $Arguments.projectId -Agent $Arguments.agent 2>&1
            return @{ content = @(@{ type = "text"; text = "$output" }) }
        }
        "factory__trello_fetch" {
            $scriptPath = Join-Path $scriptDir "trello_service.ps1"
            $output = & $scriptPath -Action FetchBoard -BoardId $Arguments.boardId 2>&1
            $text = $output | ConvertTo-Json
            return @{ content = @(@{ type = "text"; text = "$text" }) }
        }
        "factory__trello_create" {
            $scriptPath = Join-Path $scriptDir "trello_service.ps1"
            $output = & $scriptPath -Action CreateTask -ListId $Arguments.listId -Name $Arguments.name -Description $Arguments.description 2>&1
            $text = $output | ConvertTo-Json
            return @{ content = @(@{ type = "text"; text = "$text" }) }
        }
        default {
            throw "Tool not found: $Name"
        }
    }
}

Write-Log "Server started."

# Main Loop
while ($line = [Console]::In.ReadLine()) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    Write-Log "IN: $line"
    
    try {
        $request = $line | ConvertFrom-Json
        $id = $request.id
        
        switch ($request.method) {
            "initialize" {
                Write-MCPResponse $id @{
                    protocolVersion = $ProtocolVersion
                    capabilities = @{
                        tools = @{ listChanged = $false }
                    }
                    serverInfo = @{ name = "gemini-agents-factory"; version = "1.0.0" }
                }
            }
            "notifications/initialized" {
                Write-Log "Notification: Initialized received."
            }
            "tools/list" {
                Write-MCPResponse $id (List-Tools)
            }
            "callTool" { # Some clients use callTool instead of tools/call
                try {
                    $result = Call-Tool $request.params.name $request.params.arguments
                    Write-MCPResponse $id $result
                } catch {
                    Write-MCPError $id -32603 "Internal error: $($_.Exception.Message)"
                }
            }
            "tools/call" {
                try {
                    $result = Call-Tool $request.params.name $request.params.arguments
                    Write-MCPResponse $id $result
                } catch {
                    Write-MCPError $id -32603 "Internal error: $($_.Exception.Message)"
                }
            }
            default {
                if ($id -ne $null) {
                    Write-MCPError $id -32601 "Method not found: $($request.method)"
                } else {
                    Write-Log "Notification for unknown method: $($request.method)"
                }
            }
        }
    } catch {
        Write-Log "CRITICAL Parse error: $($_.Exception.Message)"
        Write-MCPError $null -32700 "Parse error: $($_.Exception.Message)"
    }
}
