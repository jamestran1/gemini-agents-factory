# Product Guide: Gemini Agent Factory

## Initial Concept
This project is about creating a factory of gemini agent. It is a company where when I start the software project, there will be product owner agent, designer ui/ux agent, project manager agent, software engineer agent, QA agent.

## Target Audience
The primary users of the Gemini Agent Factory include:
- **Software Developers:** Looking to accelerate their workflows and delegate tasks to AI counterparts.
- **Non-Technical Founders:** Needing a complete virtual team to build and launch their product ideas.
- **Project Managers:** Wanting to efficiently oversee AI agents building the product, directing the overall progress.

## Primary Outputs
The factory is capable of generating a wide range of software artifacts:
- **MVPs & Prototypes:** For quick validation of product ideas.
- **Production-Ready Apps:** Complete with automated tests, documentation, and CI/CD setups.
- **Specialized Modules:** Individual components such as APIs, UI elements, or microservices.
- **Open Source Projects:** Built following community standards and best practices to ensure they are easily evolvable by human contributors.

## Agent Workflow & Collaboration
- **Framework Status:** The core collaborative 5-role framework is implemented as a **Native Gemini CLI Extension**.
- **Sequential Handoff:** Traditional linear progression (PM -> Designer -> Engineer -> QA).
- **Collaborative Chat:** Supported via the `message_bus.ps1` shared context and "Context Message Bus" skill.
- **Central Orchestrator:** Implemented via `orchestrator.ps1` and a dedicated **Master Orchestrator Agent** (`master`) for dynamic delegation.
- **Parallel Processing:** Supported! Agents can be spawned in background sessions or new windows for concurrent project work using the "Factory Agent Launcher" skill.

## Supported Platforms & Integration
- **Platform Agnostic:** Capable of building Web Applications, Mobile Applications, or adapting to any framework specified in the prompt.
- **Task Management:** The factory features deep integration with Trello via `trello_service.ps1` and the "Trello Management" skill.
- **CLI Integration:** Native integration via the `/fnew` slash command for initializing and launching projects.
- **Extension Access:** Agents and Skills are integrated into the global CLI ecosystem for easy "hiring" and tool use.
