# Skill: Factory Agent Launcher

Launch and manage factory agent sessions in foreground or background.

## Usage

This skill provides access to the `start_factory.ps1` and `spawn_agent.ps1` scripts.

### Launch Foreground Session (e.g., Master Orchestrator)
`powershell.exe -NoProfile -Command ".\src\start_factory.ps1 -ProjectId '<ID>' -Agent '<Role>'"`

### Spawn Background Agent (e.g., Software Engineer)
`powershell.exe -NoProfile -Command ".\src\spawn_agent.ps1 -ProjectId '<ID>' -Agent '<Role>'"`

## Features
- Automatic persona loading via `GEMINI_SYSTEM_MD`.
- Custom window titles and stylized headers.
- Background tasks run in minimized windows.
