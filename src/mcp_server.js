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
  } catch (err) {}
}

const server = new Server(
  {
    name: "gemini-agents-factory",
    version: "1.1.2",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
  writeLog("LIST_TOOLS requested");
  return {
    tools: [
      {
        name: "factory__add_project",
        description: "Add a new project to the factory manifest.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string" },
            name: { type: "string" },
          },
          required: ["projectId", "name"],
        },
      },
      {
        name: "factory__list_projects",
        description: "List all projects.",
        inputSchema: { type: "object", properties: {} },
      },
      {
        name: "factory__send_message",
        description: "Send a message to context bus.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string" },
            from: { type: "string" },
            to: { type: "string" },
            message: { type: "string" },
          },
          required: ["projectId", "from", "to", "message"],
        },
      },
      {
        name: "factory__get_messages",
        description: "Get messages from context bus.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string" },
            to: { type: "string" },
          },
          required: ["projectId", "to"],
        },
      },
      {
        name: "factory__start_session",
        description: "Launch a foreground session.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string" },
          },
          required: ["projectId"],
        },
      },
      {
        name: "factory__spawn_agent",
        description: "Spawn a background agent.",
        inputSchema: {
          type: "object",
          properties: {
            projectId: { type: "string" },
            agent: { type: "string" },
          },
          required: ["projectId", "agent"],
        },
      },
      {
        name: "factory__trello_fetch",
        description: "Fetch Trello board.",
        inputSchema: {
          type: "object",
          properties: {
            boardId: { type: "string" },
          },
          required: ["boardId"],
        },
      },
      {
        name: "factory__trello_create",
        description: "Create Trello card.",
        inputSchema: {
          type: "object",
          properties: {
            listId: { type: "string" },
            name: { type: "string" },
            description: { type: "string" },
          },
          required: ["listId", "name"],
        },
      },
    ],
  };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  writeLog(`CALLING: ${name}`);

  try {
    switch (name) {
      case "factory__add_project":
        return { content: [{ type: "text", text: JSON.stringify(await projectState.addProject(args.projectId, args.name)) }] };
      case "factory__list_projects":
        return { content: [{ type: "text", text: JSON.stringify(await projectState.listProjects()) }] };
      case "factory__send_message":
        await messageBus.sendMessage(args.projectId, args.from, args.to, args.message);
        return { content: [{ type: "text", text: "OK" }] };
      case "factory__get_messages":
        return { content: [{ type: "text", text: JSON.stringify(await messageBus.getMessages(args.projectId, args.to)) }] };
      case "factory__start_session":
        return { content: [{ type: "text", text: await launcher.startSession(args.projectId, "master") }] };
      case "factory__spawn_agent":
        return { content: [{ type: "text", text: await launcher.spawnAgent(args.projectId, args.agent) }] };
      case "factory__trello_fetch":
        return { content: [{ type: "text", text: JSON.stringify(await trelloService.fetchBoard(args.boardId)) }] };
      case "factory__trello_create":
        return { content: [{ type: "text", text: JSON.stringify(await trelloService.createTask(args.listId, args.name, args.description)) }] };
      default:
        return { content: [{ type: "text", text: `Unknown tool: ${name}` }], isError: true };
    }
  } catch (error) {
    writeLog(`TOOL_ERROR: ${error.message}`);
    return { content: [{ type: "text", text: `Error: ${error.message}` }], isError: true };
  }
});

async function run() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  writeLog("READY");
}

run().catch((err) => {
  writeLog(`FATAL: ${err.message}`);
});
