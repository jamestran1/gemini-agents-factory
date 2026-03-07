# Implementation Plan: Autonomous Factory Runner & Parallel Multi-Project Engine

## Phase 1: Multi-Project Brain (Message Bus Update) [checkpoint: a94fa79]
- [x] Task: Update `message_bus.ps1` to support unique `project_id` contexts (d34e081)
    - [x] Write Tests (Test sending/getting messages in two independent project contexts)
    - [x] Implement Feature
- [x] Task: Create a `Project State` manifest to track all active/archived project IDs (28bd386)
    - [x] Write Tests (Verify tracking of multiple projects)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 1: Multi-Project Brain' (Protocol in workflow.md) (a94fa79)

## Phase 2: Master Orchestrator & MCP/Skill Empowerment [checkpoint: 70d83d8]
- [x] Task: Define the `Master Orchestrator` agent prompt (`src/agents/master.md`) (dd987b0)
    - [x] Write Tests (Verify master agent logic and delegation capability)
    - [x] Implement Feature
- [x] Task: Update all agent system prompts to explicitly reference Skill/MCP usage (7f6fa89)
    - [x] Write Tests (Confirm prompts now include MCP instructions)
    - [x] Implement Feature
- [x] Task: Conductor - User Manual Verification 'Phase 2: Master Orchestrator & MCP/Skill Empowerment' (Protocol in workflow.md) (70d83d8)

## Phase 3: CLI Integration & Parallel Runner
- [x] Task: Implement a `start-factory.ps1` script to launch independent CLI sessions (6988823)
    - [x] Write Tests (Mock CLI session launch)
    - [x] Implement Feature
- [x] Task: Create a Gemini CLI slash command (e.g., `/fnew`) using a custom hook or command (d21fe9c)
    - [x] Write Tests (Verify command registration and initial execution)
    - [x] Implement Feature
- [x] Task: Implement background task spawning for agents (Async execution) (203c699)
    - [x] Write Tests (Test spawning an agent in the background)
    - [x] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 3: CLI Integration & Parallel Runner' (Protocol in workflow.md)
