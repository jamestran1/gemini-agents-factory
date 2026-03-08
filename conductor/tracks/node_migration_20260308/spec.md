# Specification: Migrate Factory Tools to Native Node.js

## Overview
This track aims to replace the current PowerShell-based implementation of the Gemini Agent Factory tools with a native Node.js implementation. This will improve performance, reliability, and provide a seamless MCP server experience without the overhead of spawning separate shell processes for each operation.

## Functional Requirements
- **Core Modules (Node.js):**
    - `projectState.js`: Manage the `projects.json` manifest.
    - `messageBus.js`: Manage isolated project contexts in `shared_context_<id>.json`.
    - `launcher.js`: Handle spawning foreground and background Gemini CLI windows using `child_process`.
- **Trello Integration:** Utilize a Node.js Trello SDK for robust API communication.
- **Unified MCP Server:** Update `src/mcp_server.js` to import and call these modules directly as native JavaScript functions.
- **Data Integrity:** Ensure JSON files are stored cleanly without any PowerShell-specific object wrappers.
- **Legacy Support:** Move existing `.ps1` scripts to a `legacy/` directory for reference.

## Non-Functional Requirements
- **Performance:** Native tool execution should be significantly faster than PowerShell child processes.
- **Error Handling:** Implement robust JavaScript try/catch blocks to ensure valid MCP JSON-RPC error responses.
- **Zero-Setup:** The extension must remain self-contained and require no manual path configuration.

## Acceptance Criteria
- Extension links correctly and `/mcp list` shows the `factory` server as **🟢 Ready** without any error warnings.
- `/fnew` command successfully initializes a project and launches a Master session using Node.js logic.
- All 8 factory tools are verified functional in a brand-new directory.
- `projects.json` and context files remain clean, human-readable JSON arrays.

## Out of Scope
- Converting the agents' system prompts (these remain as `.md` files).
- Migrating the `conductor` workflow logic.