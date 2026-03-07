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
- **Framework Status:** The core collaborative 5-role framework is implemented.
- **Sequential Handoff:** Traditional linear progression (PM -> Designer -> Engineer -> QA).
- **Collaborative Chat:** Supported via the `message_bus.ps1` shared context.
- **Central Orchestrator:** Implemented via `orchestrator.ps1` for dynamic delegation.
- **Parallel Processing:** (Planned) Support for multiple agents of the same role.

## Supported Platforms & Integration
- **Platform Agnostic:** Capable of building Web Applications, Mobile Applications, or adapting to any framework specified in the prompt.
- **Task Management:** The factory features deep integration with Trello via `trello_service.ps1`, allowing agents to manage, track, and update tasks autonomously.
