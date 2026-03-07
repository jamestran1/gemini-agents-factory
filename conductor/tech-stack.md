# Technology Stack: Gemini Agent Factory

## Core Ecosystem
- **Platform:** Gemini CLI
- **Agents:** Gemini Subagents (Product Owner, Designer, Project Manager, Software Engineer, QA)

## Orchestration & Workflow
- **Task Management:** Conductor extension for the Gemini CLI
- **Execution:** Automated workflows leveraging Conductor's `/conductor:implement` and task generation features
- **Integration:** Custom hooks or subagents to communicate via Trello APIs for external task tracking

## Implementation Details
- **Configuration:** Markdown (`.md`) and JSON files for agent definitions and workflows
- **Scripts:** PowerShell / Bash for any custom scripting or tool execution