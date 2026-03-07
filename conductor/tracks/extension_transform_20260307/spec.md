# Specification: Transform Factory into Installable Extension

## Overview
This track aims to package the "Gemini Agent Factory" project as a native Gemini CLI extension. This transformation will allow users to install the factory via a single command, leverage its capabilities as official Skills, and ensure a seamless, portable experience across different environments.

## Functional Requirements
- **Manifest Creation:** Define `gemini-extension.json` with metadata, versioning, and capability declarations.
- **Native Command Registration:** Migrate the `/fnew` command to the standard extension directory structure.
- **Sub-Agent Promotion:** Move all agent definitions (`master.md`, `product_owner.md`, etc.) to the root `agents/` directory so they are recognized as native Gemini sub-agents.
- **Skill Implementation:** Wrap existing PowerShell logic (Trello, Message Bus, Session Launch) into official Gemini CLI Skills.
- **Path Portability:** Update all references within scripts and prompts to use `${extensionPath}` to ensure relative paths resolve correctly regardless of the installation location.
- **Installation Documentation:** Update `README.md` with clear instructions for installing the extension via GitHub URL.

## Non-Functional Requirements
- **Encapsulation:** All factory-specific logic should be contained within the extension's structure.
- **Maintainability:** Ensure the transition from "Pure Extension Mode" (replacing direct PS1 calls) improves the overall code organization.

## Acceptance Criteria
- Extension can be installed via `gemini extensions install <GitHub-URL>`.
- `/fnew` command appears in `/help` and works as expected.
- Agents can be invoked as native sub-agents.
- Skills (Trello, Context Bus, Launcher) are listed in `/skills list`.
- No hardcoded absolute paths remain in the codebase.

## Out of Scope
- Listing in the official CLI Gallery Registry (planned for a later track).
- Migration of the `conductor` files into the extension (these remain as project-level management tools).