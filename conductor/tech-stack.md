# Technology Stack: Gemini Agent Factory

## Core Ecosystem
- **Platform:** Gemini CLI
- **Agents:** Gemini Subagents (Master, Product Owner, Designer, Project Manager, Software Engineer, QA) promoted to native extension agents.
- **Capabilities:** Full exploitation of installed **Gemini CLI Skills** and **MCP (Model Context Protocol)** tools by all agent roles.

## Orchestration & Workflow
- **Task Management:** Native Trello integration via Node.js wrapped in the **Trello Management Skill**.
- **Execution Engine:** Native Node.js launcher wrapped in the **Factory Agent Launcher Skill**.
- **Context Management:** Native Node.js message bus wrapped in the **Context Message Bus Skill**.
- **Command Interface:** Native slash commands defined in the `commands/` directory (e.g., `/fnew`).
- **State Management:** Native Node.js module for multi-project manifest tracking.

## Implementation Details
- **Core Engine:** High-performance **Node.js MCP Server** using the official `@modelcontextprotocol/sdk`.
- **Configuration:** `gemini-extension.json` for extension metadata and configuration.
- **Agent Definitions:** Markdown (`.md`) with YAML frontmatter in the `agents/` directory.
- **Command Definitions:** TOML format in the `commands/` directory.
- **Backend:** JavaScript (Node.js) for core logic, JSON for project state and shared context.
- **Legacy:** Original PowerShell scripts archived in `legacy/`.
- **Persona Isolation:** Uses `GEMINI_SYSTEM_MD` environment variable to ensure agents start with correct system instructions.
