# Skill: Factory Agent Launcher

Launch and manage factory agent sessions in foreground or background using native MCP tools.

## Usage

This skill utilizes the factory's MCP tools for session management.

### Launch Foreground Session (e.g., Master Orchestrator)
Use the `factory__start_session` tool with:
- `projectId`: Unique ID for the project.

### Spawn Background Agent (e.g., Software Engineer)
Use the `factory__spawn_agent` tool with:
- `projectId`: Unique ID for the project.
- `agent`: The agent role to spawn (e.g., 'software_engineer').

## Features
- Automatic persona loading via `GEMINI_SYSTEM_MD` (managed by the extension).
- Global path resolution for agent prompt files.
- Visual session isolation with custom window titles.
