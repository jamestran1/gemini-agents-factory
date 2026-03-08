# Implementation Plan: Encapsulate Factory as a Native MCP-Powered Extension

## Phase 1: PowerShell MCP Server Implementation [checkpoint: 158ffe9]
- [x] Task: Implement core MCP JSON-RPC handler in `src/mcp_server.ps1` (c1b2fbd)
    - [x] Write Tests (Verify initialization and list_tools messages)
    - [x] Implement Feature
- [x] Task: Implement tool routing logic in `src/mcp_server.ps1` (13b9d41)
    - [x] Write Tests (Test calling a mock tool via JSON-RPC)
    - [x] Implement Feature
- [x] Task: Map factory scripts to MCP tools (`factory__add_project`, etc.) (73f5491)
    - [x] Write Tests (Verify specific tool calls return expected results)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 1: PowerShell MCP Server Implementation' (Protocol in workflow.md) (158ffe9)

## Phase 2: Manifest & Global Integration
- [x] Task: Register MCP server in `gemini-extension.json` (d2f2e3b)
    - [x] Write Tests (Verify manifest structure with mcpServers entry)
    - [x] Implement Feature
- [x] Task: Ensure all factory scripts handle absolute paths relative to their own location (2a1b12a)
    - [x] Write Tests (Verify scripts find dependencies when run from outside the extension)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 2: Manifest & Global Integration' (Protocol in workflow.md) (2a1b12a)

## Phase 3: Component Refactoring [checkpoint: 7dd7228]
- [x] Task: Update `commands/fnew.toml` to use `factory__` tools (a0d96f1)
    - [x] Write Tests (Verify command string logic)
    - [x] Implement Feature
- [x] Task: Update all `skills/**/SKILL.md` to use global tool names (2f0796a)
    - [x] Write Tests (Verify skill instructions)
    - [x] Implement Feature
- [x] Task: Update all `agents/*.md` prompts to reference global tools (bbb0fb9)
    - [x] Write Tests (Verify agent instructions)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 3: Component Refactoring' (Protocol in workflow.md) (7dd7228)

## Phase 4: Final Verification & Zero-Setup Test
- [x] Task: Perform end-to-end test in a brand-new directory (65add1a)
    - [x] Write Tests (Automated verification of project initialization in a temporary dir)
    - [x] Implement Feature
- [x] Task: Update `README.md` to highlight Zero-Setup benefits (d1ad282)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 4: Final Verification & Zero-Setup Test' (Protocol in workflow.md) (d1ad282)