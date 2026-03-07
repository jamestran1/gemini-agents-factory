# Technology Stack: Gemini Agent Factory

## Core Ecosystem
- **Platform:** Gemini CLI
- **Agents:** Gemini Subagents (Master, Product Owner, Designer, Project Manager, Software Engineer, QA)
- **Capabilities:** Full exploitation of installed **Gemini CLI Skills** and **MCP (Model Context Protocol)** tools by all agent roles.

## Orchestration & Workflow
- **Task Management:** Conductor extension for the Gemini CLI and native Trello integration via `trello_service.ps1`.
- **Execution Engine:** `start_factory.ps1` and `spawn_agent.ps1` for foreground and background session management.
- **Command Interface:** Custom `/fnew` slash command for project bootstrapping.
- **State Management:** `project_state.ps1` for multi-project manifest tracking and `message_bus.ps1` for isolated project contexts.

## Implementation Details
- **Configuration:** Markdown (`.md`) for agent definitions and JSON files for project state and shared context.
- **Scripts:** PowerShell for system-level orchestration, session management, and API integration.
- **Persona Isolation:** Uses `GEMINI_SYSTEM_MD` environment variable to ensure agents start with correct system instructions.
