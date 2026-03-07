# Technology Stack: Gemini Agent Factory

## Core Ecosystem
- **Platform:** Gemini CLI
- **Agents:** Gemini Subagents (Master, Product Owner, Designer, Project Manager, Software Engineer, QA) promoted to native extension agents.
- **Capabilities:** Full exploitation of installed **Gemini CLI Skills** and **MCP (Model Context Protocol)** tools by all agent roles.

## Orchestration & Workflow
- **Task Management:** Native Trello integration via `trello_service.ps1` wrapped in the **Trello Management Skill**.
- **Execution Engine:** `start_factory.ps1` and `spawn_agent.ps1` wrapped in the **Factory Agent Launcher Skill**.
- **Context Management:** `message_bus.ps1` wrapped in the **Context Message Bus Skill**.
- **Command Interface:** Native slash commands defined in the `commands/` directory (e.g., `/fnew`).
- **State Management:** `project_state.ps1` for multi-project manifest tracking.

## Implementation Details
- **Configuration:** `gemini-extension.json` for extension metadata and configuration.
- **Agent Definitions:** Markdown (`.md`) with YAML frontmatter in the `agents/` directory.
- **Command Definitions:** TOML format in the `commands/` directory.
- **Scripts:** PowerShell for system-level orchestration and API integration, using `${extensionPath}` portability.
- **Persona Isolation:** Uses `GEMINI_SYSTEM_MD` environment variable to ensure agents start with correct system instructions.
