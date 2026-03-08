# Implementation Plan: Migrate Factory Tools to Native Node.js

## Phase 1: Core Module Migration (State & Context)
- [ ] Task: Implement `src/projectState.js`
    - [ ] Write Tests (Validate JSON array management)
    - [ ] Implement Feature
- [ ] Task: Implement `src/messageBus.js`
    - [ ] Write Tests (Validate isolated project context logic)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Core Module Migration' (Protocol in workflow.md)

## Phase 2: Trello & Launcher Migration
- [ ] Task: Implement `src/trelloService.js` using Node.js SDK/Rest
    - [ ] Write Tests (Mock Trello API responses)
    - [ ] Implement Feature
- [ ] Task: Implement `src/launcher.js` for forensic/background sessions
    - [ ] Write Tests (Mock child_process spawning)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Trello & Launcher Migration' (Protocol in workflow.md)

## Phase 3: Unified MCP Server & Cleanup
- [ ] Task: Refactor `src/mcp_server.js` to call native modules directly
    - [ ] Write Tests (Verify MCP tool list and tool calls via SDK)
    - [ ] Implement Feature
- [ ] Task: Move existing `.ps1` scripts to `legacy/`
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Unified MCP Server & Cleanup' (Protocol in workflow.md)

## Phase 4: Final Verification
- [ ] Task: Perform end-to-end Zero-Setup test in a new workspace
    - [ ] Implement Feature
- [ ] Task: Update `README.md` and `tech-stack.md`
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Final Verification' (Protocol in workflow.md)