# Skill: Trello Management

Manage Trello boards and tasks using the factory's Trello service.

## Usage

This skill provides access to the `trello_service.ps1` script.

### Fetch a Board
`powershell.exe -NoProfile -Command ".\src\trello_service.ps1 -Action FetchBoard -BoardId <ID>"`

### Create a Task (Card)
`powershell.exe -NoProfile -Command ".\src\trello_service.ps1 -Action CreateTask -ListId <ID> -Name '<Name>' -Description '<Desc>'"`

## Prerequisites
- `TRELLO_API_KEY` and `TRELLO_TOKEN` environment variables must be set.
