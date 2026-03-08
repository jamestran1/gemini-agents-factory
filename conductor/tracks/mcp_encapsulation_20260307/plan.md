# Implementation Plan: Encapsulate Factory as a Native MCP-Powered Extension

## Phase 1: PowerShell MCP Server Implementation
- [ ] Task: Implement core MCP JSON-RPC handler in `src/mcp_server.ps1`
    - [ ] Write Tests (Verify initialization and list_tools messages)
    - [ ] Implement Feature
- [ ] Task: Implement tool routing logic in `src/mcp_server.ps1`
    - [ ] Write Tests (Test calling a mock tool via JSON-RPC)
    - [ ] Implement Feature
- [ ] Task: Map factory scripts to MCP tools (`factory__add_project`, etc.)
    - [ ] Write Tests (Verify specific tool calls return expected results)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 1: PowerShell MCP Server Implementation' (Protocol in workflow.md)

## Phase 2: Manifest & Global Integration
- [ ] Task: Register MCP server in `gemini-extension.json`
    - [ ] Write Tests (Verify manifest structure with mcpServers entry)
    - [ ] Implement Feature
- [ ] Task: Ensure all factory scripts handle absolute paths relative to their own location
    - [ ] Write Tests (Verify scripts find dependencies when run from outside the extension)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Manifest & Global Integration' (Protocol in workflow.md)

## Phase 3: Component Refactoring
- [ ] Task: Update `commands/fnew.toml` to use `factory__` tools
    - [ ] Write Tests (Verify command string logic)
    - [ ] Implement Feature
- [ ] Task: Update all `skills/**/SKILL.md` to use global tool names
    - [ ] Write Tests (Verify skill instructions)
    - [ ] Implement Feature
- [ ] Task: Update all `agents/*.md` prompts to reference global tools
    - [ ] Write Tests (Verify agent instructions)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Component Refactoring' (Protocol in workflow.md)

## Phase 4: Final Verification & Zero-Setup Test
- [ ] Task: Perform end-to-end test in a brand-new directory
    - [ ] Write Tests (Automated verification of project initialization in a temporary dir)
    - [ ] Implement Feature
- [ ] Task: Update `README.md` to highlight Zero-Setup benefits
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Final Verification & Zero-Setup Test' (Protocol in workflow.md)