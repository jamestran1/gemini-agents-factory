# Skill: Context Message Bus

Facilitate communication and state sharing between agents using the factory's message bus.

## Usage

This skill provides access to the `message_bus.ps1` script.

### Send a Message
`powershell.exe -NoProfile -Command ".\src\message_bus.ps1 -Action Send -From '<Agent>' -To '<Target>' -Message '<Content>' -ProjectId '<ID>'"`

### Get Messages
`powershell.exe -NoProfile -Command ".\src\message_bus.ps1 -Action Get -To '<Agent>' -ProjectId '<ID>'"`

## Features
- Isolated contexts per `ProjectId`.
- Persistent JSON-based message history.
