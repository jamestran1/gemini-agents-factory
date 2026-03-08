# Skill: Context Message Bus

Facilitate communication and state sharing between agents using the factory's native context message bus.

## Usage

This skill utilizes the factory's MCP tools for message bus operations.

### Send a Message
Use the `factory__send_message` tool with:
- `projectId`: Unique ID for the project.
- `from`: The sender's role (e.g., 'product_owner').
- `to`: The recipient's role (e.g., 'designer').
- `message`: The content of the message.

### Get Messages
Use the `factory__get_messages` tool with:
- `projectId`: Unique ID for the project.
- `to`: Filter messages for this recipient role.

## Features
- Isolated contexts per `projectId`.
- Persistent message history managed globally by the factory extension.
