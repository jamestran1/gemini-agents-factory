# Specification: Encapsulate Factory as a Native MCP-Powered Extension

## Overview
This track transforms the "Gemini Agent Factory" into a fully self-contained, "zero-setup" extension by implementing a native PowerShell-based MCP (Model Context Protocol) server. By exposing our PowerShell scripts as global MCP tools, we eliminate the need for relative path searching or environment variable configuration, allowing the factory to function perfectly in any directory immediately after installation.

## Functional Requirements
- **PowerShell MCP Server:** Implement `src/mcp_server.ps1` to handle the MCP JSON-RPC protocol.
- **Tool Exposure:** Map existing factory logic to formal MCP tools:
    - `factory__add_project`: Exposes `project_state.ps1 -Action Add`.
    - `factory__list_projects`: Exposes `project_state.ps1 -Action List`.
    - `factory__send_message`: Exposes `message_bus.ps1 -Action Send`.
    - `factory__get_messages`: Exposes `message_bus.ps1 -Action Get`.
    - `factory__start_session`: Exposes `start_factory.ps1`.
    - `factory__spawn_agent`: Exposes `spawn_agent.ps1`.
    - `factory__trello_fetch`: Exposes `trello_service.ps1 -Action FetchBoard`.
    - `factory__trello_create`: Exposes `trello_service.ps1 -Action CreateTask`.
- **Manifest Integration:** Register the MCP server in `gemini-extension.json` using the `${extensionPath}` substitution variable for path independence.
- **Global Refactor:**
    - Update `commands/fnew.toml` to invoke MCP tools instead of raw PowerShell.
    - Update all `skills/**/SKILL.md` files to point to the `factory__` toolset.
    - Update all agent system prompts (`agents/*.md`) to utilize the global tools for autonomous delegation and state management.

## Non-Functional Requirements
- **Path Independence:** No script should rely on the current working directory for its own location.
- **Protocol Compliance:** The server must correctly implement the standard MCP lifecycle (Initialize, Tool Listing, Call Tool).

## Acceptance Criteria
- Extension can be linked/installed and lists all `factory__` tools in `/mcp list`.
- Running `/fnew` in a brand new, empty directory successfully initializes the state and launches the Master Orchestrator.
- Sub-agents can successfully call the MCP tools during a collaborative session.

## Out of Scope
- Migrating the PowerShell logic to Node.js (we are keeping the core logic in PowerShell for now).
- Implementing a custom UI for the MCP server.