# Track: Implement Autonomous Factory Runner with Parallel Multi-Project & MCP Support

## Goal
Transform the agent definitions into an autonomous team capable of running directly within the Gemini CLI, handling multiple concurrent project sessions, and fully utilizing installed skills and MCP tools.

## Requirements
- Create a `Master Orchestrator` agent as the primary entry point.
- Implement multi-project context management in the `message_bus.ps1`.
- Update all agent prompts to explicitly include and leverage Gemini CLI Skills and MCP tools.
- Implement a CLI command or hook to launch factory instances.
- Build a parallel execution engine to allow background agent tasks across different work sessions.
- Ensure state persistence for each project context.
