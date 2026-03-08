# Implementation Plan: Migrate Factory Tools to Native Node.js

## Phase 1: Core Module Migration (State & Context) [checkpoint: 7344110]
- [x] Task: Implement `src/projectState.js` (3b0a245)
    - [x] Write Tests (Validate JSON array management)
    - [x] Implement Feature
- [x] Task: Implement `src/messageBus.js` (7c6e4cd)
    - [x] Write Tests (Validate isolated project context logic)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 1: Core Module Migration' (Protocol in workflow.md) (7344110)

## Phase 2: Trello & Launcher Migration
- [x] Task: Implement `src/trelloService.js` using Node.js SDK/Rest (3e5f4df)
    - [x] Write Tests (Mock Trello API responses)
    - [x] Implement Feature
- [~] Task: Implement `src/launcher.js` for forensic/background sessions
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