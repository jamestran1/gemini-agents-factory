# Implementation Plan: Autonomous Factory Runner & Parallel Multi-Project Engine

## Phase 1: Multi-Project Brain (Message Bus Update)
- [x] Task: Update `message_bus.ps1` to support unique `project_id` contexts (d34e081)
    - [x] Write Tests (Test sending/getting messages in two independent project contexts)
    - [x] Implement Feature
- [ ] Task: Create a `Project State` manifest to track all active/archived project IDs
    - [ ] Write Tests (Verify tracking of multiple projects)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Multi-Project Brain' (Protocol in workflow.md)

## Phase 2: Master Orchestrator & MCP/Skill Empowerment
- [ ] Task: Define the `Master Orchestrator` agent prompt (`src/agents/master.md`)
    - [ ] Write Tests (Verify master agent logic and delegation capability)
    - [ ] Implement Feature
- [ ] Task: Update all agent system prompts to explicitly reference Skill/MCP usage
    - [ ] Write Tests (Confirm prompts now include MCP instructions)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Master Orchestrator & MCP/Skill Empowerment' (Protocol in workflow.md)

## Phase 3: CLI Integration & Parallel Runner
- [ ] Task: Implement a `start-factory.ps1` script to launch independent CLI sessions
    - [ ] Write Tests (Mock CLI session launch)
    - [ ] Implement Feature
- [ ] Task: Create a Gemini CLI slash command (e.g., `/factory:new`) using a custom hook or command
    - [ ] Write Tests (Verify command registration and initial execution)
    - [ ] Implement Feature
- [ ] Task: Implement background task spawning for agents (Async execution)
    - [ ] Write Tests (Test spawning an agent in the background)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 3: CLI Integration & Parallel Runner' (Protocol in workflow.md)
