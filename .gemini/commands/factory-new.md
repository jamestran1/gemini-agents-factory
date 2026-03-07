---
description: Start a new factory project session with a Master Orchestrator
argument-hint: [project-id] [project-name]
allowed-tools: Bash(*)
---

Start a new Gemini Agent Factory session for project "$1" ($2).

Instructions for Claude:
1. Validate arguments: Ensure both a project ID and a project name are provided.
2. Initialize Project State: Run !`powershell.exe -NoProfile -Command ".\src\project_state.ps1 -Action Add -ProjectId '$1' -Name '$2'"`
3. Launch Master Orchestrator Session: Run !`powershell.exe -NoProfile -Command ".\src\start_factory.ps1 -ProjectId '$1' -Agent 'master'"`
4. Report status to the user: Confirm the session has been launched in a new window.
