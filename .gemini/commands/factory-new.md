---
description: Start a new factory project session with a Master Orchestrator
argument-hint: <project-id> <project-name>
allowed-tools: Bash(*)
---

$IF($1,
  $IF($2,
    Start a new Gemini Agent Factory session for project "$1" ($2).

    Instructions for Claude:
    1. Initialize Project State: Run !`powershell.exe -NoProfile -Command ".\src\project_state.ps1 -Action Add -ProjectId '$1' -Name '$2'"`
    2. Launch Master Orchestrator Session: Run !`powershell.exe -NoProfile -Command ".\src\start_factory.ps1 -ProjectId '$1' -Agent 'master'"`
    3. Report status: Confirm the session has been launched in a new window.
    ,
    Missing project name. Usage: /factory-new <project-id> <project-name>
  ),
  Missing project ID and name. Usage: /factory-new <project-id> <project-name>
)
