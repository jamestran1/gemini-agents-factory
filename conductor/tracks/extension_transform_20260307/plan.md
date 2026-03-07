# Implementation Plan: Transform Factory into Installable Extension

## Phase 1: Extension Scaffolding & Manifest
- [x] Task: Create `gemini-extension.json` manifest file (1470586)
    - [x] Write Tests (Validate JSON structure and mandatory fields)
    - [x] Implement Feature
- [ ] Task: Reorganize directory structure for extension standards
    - [ ] Move `.gemini/commands/*.toml` to `commands/`
    - [ ] Move `src/agents/*.md` to `agents/`
    - [ ] Create `skills/` directory
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Extension Scaffolding & Manifest' (Protocol in workflow.md)

## Phase 2: Skill Implementation & Tool Wrapping
- [ ] Task: Implement Trello Skill in `skills/trello/SKILL.md`
    - [ ] Write Tests (Verify skill instructions and tool references)
    - [ ] Implement Feature
- [ ] Task: Implement Context Bus Skill in `skills/message-bus/SKILL.md`
    - [ ] Write Tests (Verify skill instructions)
    - [ ] Implement Feature
- [ ] Task: Implement Factory Launcher Skill in `skills/launcher/SKILL.md`
    - [ ] Write Tests (Verify skill instructions)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Skill Implementation & Tool Wrapping' (Protocol in workflow.md)

## Phase 3: Path Portability & Native Integration
- [ ] Task: Update PowerShell scripts to resolve paths relative to extension root
    - [ ] Write Tests (Verify script execution with dynamic paths)
    - [ ] Implement Feature
- [ ] Task: Update Agent System Prompts to use Extension-native references
    - [ ] Write Tests (Verify prompts reference skills and relative paths)
    - [ ] Implement Feature
- [ ] Task: Update `/fnew` command to use extension-aware paths and skills
    - [ ] Write Tests (Verify command logic)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Path Portability & Native Integration' (Protocol in workflow.md)

## Phase 4: Finalization & Documentation
- [ ] Task: Update `README.md` with official installation instructions
    - [ ] Write Tests (Verify README accuracy)
    - [ ] Implement Feature
- [ ] Task: Verify end-to-end installation flow using `gemini extensions link`
    - [ ] Write Tests (Simulate local link and test command/agent availability)
    - [ ] Implement Feature
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Finalization & Documentation' (Protocol in workflow.md)