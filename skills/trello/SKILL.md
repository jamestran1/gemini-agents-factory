# Skill: Trello Management

Manage Trello boards and tasks using the factory's native MCP tools.

## Usage

This skill utilizes the factory's MCP tools for Trello operations.

### Fetch a Board
Use the `factory__trello_fetch` tool with:
- `boardId`: The ID of the Trello board.

### Create a Task (Card)
Use the `factory__trello_create` tool with:
- `listId`: The ID of the Trello list.
- `name`: The title of the card.
- `description`: (Optional) The description of the card.

## Prerequisites
- `TRELLO_API_KEY` and `TRELLO_TOKEN` must be configured in the extension settings.
