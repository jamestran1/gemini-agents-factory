const { Server } = require("@modelcontextprotocol/sdk/server/index.js");
const { StdioServerTransport } = require("@modelcontextprotocol/sdk/server/stdio.js");
const { CallToolRequestSchema, ListToolsRequestSchema } = require("@modelcontextprotocol/sdk/types.js");
const projectState = require("./projectState");
const messageBus = require("./messageBus");
const launcher = require("./launcher");
const trelloService = require("./trelloService");
const fs = require("fs");
const path = require("path");

const logFile = path.join(__dirname, "mcp_server_node.log");

function writeLog(message) {
  try {
    const timestamp = new Date().toISOString();
    fs.appendFileSync(logFile, `[${timestamp}] ${message}\n`);
  } catch (err) {
    // Ignore log errors
  }
}

writeLog("Server starting...");

const server = new Server(
  {
    name: "gemini-agents-factory",
    version: "1.1.1",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
  writeLog("REQUEST: list_tools");
  return {
    tools: [
      {
        name: "factory__add_project",
        description: "Add a new project to the factory manifest.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string", description: "Unique ID for the project." },
            name: { type: "string", description: "Display name for the project." },
          },
          required: ["projectId", "name"],
        },
      },
      {
        name: "factory__list_projects",
        description: "List all projects in the factory manifest.",
        inputSchema: { type: "object", properties: {} },
      },
      {
        name: "factory__send_message",
        description: "Send a message to the project's shared context bus.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string", description: "Project ID." },
            from: { type: "string", description: "Sender agent role." },
            to: { type: "string", description: "Recipient agent role." },
            message: { type: "string", description: "Message content." },
          },
          required: ["projectId", "from", "to", "message"],
        },
      },
      {
        name: "factory__get_messages",
        description: "Retrieve messages for an agent from the context bus.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string", description: "Project ID." },
            to: { type: "string", description: "Recipient agent role filter." },
          },
          required: ["projectId", "to"],
        },
      },
      {
        name: "factory__start_session",
        description: "Launch a foreground Master Orchestrator session for a project.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string", description: "Project ID." },
          },
          required: ["projectId"],
        },
      },
      {
        name: "factory__spawn_agent",
        description: "Spawn a background agent task for a project.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string", description: "Project ID." },
            agent: { type: "string", description: "Agent role to spawn (e.g. software_engineer)." },
          },
          required: ["projectId", "agent"],
        },
      },
      {
        name: "factory__trello_fetch",
        description: "Fetch a Trello board's details.",
        inputSchema: {
          type: "object",
          properties: {
            boardId: { type: "string", description: "Trello Board ID." },
          },
          required: ["boardId"],
        },
      },
      {
        name: "factory__trello_create",
        description: "Create a new card (task) on a Trello list.",
        inputSchema: {
          type: "object",
          properties: {
            listId: { type: "string", description: "Trello List ID." },
            name: { type: "string", description: "Card title." },
            description: { type: "string", description: "Card description." },
          },
          required: ["listId", "name"],
        },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  writeLog(`CALL: ${name} with ${JSON.stringify(args)}`);

  try {
    let result;
    switch (name) {
      case "factory__add_project":
        writeLog("Executing addProject...");
        result = await projectState.addProject(args.projectId, args.name);
        writeLog("addProject complete.");
        return { content: [{ type: "text", text: JSON.stringify(result) }] };
      case "factory__list_projects":
        result = await projectState.listProjects();
        return { content: [{ type: "text", text: JSON.stringify(result) }] };
      case "factory__send_message":
        await messageBus.sendMessage(args.projectId, args.from, args.to, args.message);
        return { content: [{ type: "text", text: "Message sent." }] };
      case "factory__get_messages":
        result = await messageBus.getMessages(args.projectId, args.to);
        return { content: [{ type: "text", text: JSON.stringify(result) }] };
      case "factory__start_session":
        result = await launcher.startSession(args.projectId, "master");
        return { content: [{ type: "text", text: result }] };
      case "factory__spawn_agent":
        result = await launcher.spawnAgent(args.projectId, args.agent);
        return { content: [{ type: "text", text: result }] };
      case "factory__trello_fetch":
        result = await trelloService.fetchBoard(args.boardId);
        return { content: [{ type: "text", text: JSON.stringify(result) }] };
      case "factory__trello_create":
        result = await trelloService.createTask(args.listId, args.name, args.description);
        return { content: [{ type: "text", text: JSON.stringify(result) }] };
      default:
        throw new Error(`Tool not found: ${name}`);
    }
  } catch (error) {
    writeLog(`ERROR: ${error.message}`);
    return {
      content: [{ type: "text", text: `Error: ${error.message || error}` }],
      isError: true,
    };
  }
});

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  writeLog("Connected.");
}

main().catch(error => {
  writeLog(`FATAL: ${error.message}`);
  process.exit(1);
});
