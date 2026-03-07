# Gemini Agent Factory 🏭

An autonomous, multi-agent software development factory built directly into the Gemini CLI.

## 🚀 Overview

Gemini Agent Factory allows you to orchestrate a virtual team of specialized AI agents to build, design, and manage software projects. It leverages the native power of Gemini CLI, custom subagents, and integrated tools like Trello to provide a seamless "Prompt to Product" experience.

## 🤖 The Team

The factory features 6 specialized roles, each with a senior persona and full access to installed Skills and MCP tools:

- **Master Orchestrator:** The central brain that manages project lifecycles and delegates tasks.
- **Product Owner:** Defines requirements, priorities, and acceptance criteria.
- **Designer UI/UX:** Creates wireframes, visual styles, and user experiences.
- **Project Manager:** Orchestrates the development cycle and manages Trello tasks.
- **Software Engineer:** Implements features using TDD and ensures code quality.
- **QA (Quality Assurance):** Verifies features and validates the final product.

## 🛠 Features

- **Autonomous Runner:** Launch independent agent sessions in new windows.
- **Parallel Multi-Project Engine:** Manage multiple concurrent projects with isolated shared contexts.
- **Native CLI Integration:** Bootstrap new projects using the `/fnew` slash command.
- **Shared Context (Message Bus):** Real-time communication and state sharing between agents.
- **Trello Automation:** Automatic task tracking and project management.
- **MCP & Skill Support:** Every agent is empowered by your installed Gemini CLI extensions.

## 📥 Installation

1. Clone this repository into your Gemini CLI workspace.
2. Ensure you have the `conductor` extension installed.
3. Set your Trello credentials:
   ```powershell
   $env:TRELLO_API_KEY = "your_key"
   $env:TRELLO_TOKEN = "your_token"
   ```
4. Reload your CLI commands:
   ```
   /commands reload
   ```

## 🎮 Usage

### Starting a New Project
Use the native slash command to bootstrap a new factory project:
```
/fnew <project-id> "<Project Name>"
```
*Example:* `/fnew weather-app "Autonomous Weather Dashboard"`

### Direct Launch
You can also launch specific agents manually via PowerShell:
```powershell
.\src\start_factory.ps1 -ProjectId "my-proj" -Agent "master"
```

## 🏗 Architecture

- **`src/agents/`**: System prompt definitions for all agent roles.
- **`src/orchestrator.ps1`**: Logic for task delegation and agent routing.
- **`src/message_bus.ps1`**: Shared context management for agent collaboration.
- **`src/trello_service.ps1`**: REST API integration for task management.
- **`.gemini/commands/`**: Custom slash command definitions for the Gemini CLI.

## 📄 License
This project is licensed under the MIT License.
