# Implementation Plan: Transform Factory into Installable Extension

## Phase 1: Extension Scaffolding & Manifest [checkpoint: e2aa7c4]
- [x] Task: Create `gemini-extension.json` manifest file (1470586)
    - [x] Write Tests (Validate JSON structure and mandatory fields)
    - [x] Implement Feature
- [x] Task: Reorganize directory structure for extension standards (4f0328e)
    - [x] Move `.gemini/commands/*.toml` to `commands/`
    - [x] Move `src/agents/*.md` to `agents/`
    - [x] Create `skills/` directory
- [x] Task: Conductor - User Manual Verification 'Phase 1: Extension Scaffolding & Manifest' (Protocol in workflow.md) (e2aa7c4)

## Phase 2: Skill Implementation & Tool Wrapping
- [x] Task: Implement Trello Skill in `skills/trello/SKILL.md` (862ac51)
    - [x] Write Tests (Verify skill instructions and tool references)
    - [x] Implement Feature
- [x] Task: Implement Context Bus Skill in `skills/message-bus/SKILL.md` (7a11e69)
    - [x] Write Tests (Verify skill instructions)
    - [x] Implement Feature
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