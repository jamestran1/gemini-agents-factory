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

- **Zero-Setup (Native MCP):** All factory tools are exposed via an integrated PowerShell MCP server.
- **Autonomous Runner:** Launch independent agent sessions in new windows.
- **Parallel Multi-Project Engine:** Manage multiple concurrent projects with isolated shared contexts.
- **Native CLI Integration:** Bootstrap new projects using the `/fnew` slash command.
- **Official Skills:** Trello Management, Context Message Bus, and Factory Agent Launcher skills.
- **Native Sub-Agents:** Access specialized agents directly using the `@` prefix.

## 📥 Installation

Install the Gemini Agent Factory directly from GitHub:
```bash
gemini extensions install https://github.com/jamestran1/gemini-agents-factory
```

**IMPORTANT:** After installing, you must "trust" any new project folder to enable the factory's MCP tools:
```bash
gemini trust
```

## 🎮 Usage

### Starting a New Project
Use the native slash command to bootstrap a new factory project:
```
/fnew <project-id> "<Project Name>"
```
*Example:* `/fnew weather-app "Autonomous Weather Dashboard"`

### Accessing Skills
View the factory's skills in the CLI:
```
/skills list
```

### Hiring Agents
Hire a specific agent for a task:
```
@designer Design a clean console output layout for our factory.
```

## 🏗 Architecture

- **`agents/`**: System prompt definitions for all agent roles.
- **`commands/`**: Native extension slash commands.
- **`skills/`**: Specialized factory skills wrapping MCP tools.
- **`src/`**: Core logic and PowerShell MCP server.

## 📄 License
This project is licensed under the MIT License.
