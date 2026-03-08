# Implementation Plan: Migrate Factory Tools to Native Node.js

## Phase 1: Core Module Migration (State & Context) [checkpoint: 7344110]
- [x] Task: Implement `src/projectState.js` (3b0a245)
    - [x] Write Tests (Validate JSON array management)
    - [x] Implement Feature
- [x] Task: Implement `src/messageBus.js` (7c6e4cd)
    - [x] Write Tests (Validate isolated project context logic)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 1: Core Module Migration' (Protocol in workflow.md) (7344110)

## Phase 2: Trello & Launcher Migration [checkpoint: da1282a]
- [x] Task: Implement `src/trelloService.js` using Node.js SDK/Rest (3e5f4df)
    - [x] Write Tests (Mock Trello API responses)
    - [x] Implement Feature
- [x] Task: Implement `src/launcher.js` for forensic/background sessions (325eba5)
    - [x] Write Tests (Mock child_process spawning)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 2: Trello & Launcher Migration' (Protocol in workflow.md) (da1282a)

## Phase 3: Unified MCP Server & Cleanup [checkpoint: cfc5b4b]
- [x] Task: Refactor `src/mcp_server.js` to call native modules directly (ad91d23)
    - [x] Write Tests (Verify MCP tool list and tool calls via SDK)
    - [x] Implement Feature
- [x] Task: Move existing `.ps1` scripts to `legacy/` (ad91d23)
- [x] Task: Conductor - User Manual Verification 'Phase 3: Unified MCP Server & Cleanup' (Protocol in workflow.md) (cfc5b4b)

## Phase 4: Final Verification [checkpoint: 9feb12c]
- [x] Task: Perform end-to-end Zero-Setup test in a new workspace (9feb12c)
    - [x] Implement Feature
- [x] Task: Update `README.md` and `tech-stack.md` (9feb12c)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 4: Final Verification' (Protocol in workflow.md) (9feb12c)