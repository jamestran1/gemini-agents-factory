const fs = require('fs');
const path = require('path');
const messageBus = require('../src/messageBus');

const testDir = path.join(__dirname, 'contexts');

describe('messageBus', () => {
  beforeEach(() => {
    if (!fs.existsSync(testDir)) {
      fs.mkdirSync(testDir);
    }
  });

  afterEach(() => {
    if (fs.existsSync(testDir)) {
      const files = fs.readdirSync(testDir);
      for (const file of files) {
        fs.unlinkSync(path.join(testDir, file));
      }
      fs.rmdirSync(testDir);
    }
  });

  test('sendMessage should create a context file and add a message', async () => {
    const projectId = 'p1';
    await messageBus.sendMessage(projectId, 'PO', 'PM', 'Hello', testDir);
    const contextFile = path.join(testDir, `shared_context_${projectId}.json`);
    expect(fs.existsSync(contextFile)).toBe(true);
    const messages = JSON.parse(fs.readFileSync(contextFile, 'utf8'));
    expect(messages).toHaveLength(1);
    expect(messages[0]).toMatchObject({
      From: 'PO',
      To: 'PM',
      Message: 'Hello'
    });
  });

  test('getMessages should return filtered messages', async () => {
    const projectId = 'p1';
    await messageBus.sendMessage(projectId, 'PO', 'PM', 'Msg 1', testDir);
    await messageBus.sendMessage(projectId, 'PM', 'PO', 'Msg 2', testDir);
    await messageBus.sendMessage(projectId, 'PO', 'SE', 'Msg 3', testDir);

    const pmMessages = await messageBus.getMessages(projectId, 'PM', testDir);
    expect(pmMessages).toHaveLength(1);
    expect(pmMessages[0].Message).toBe('Msg 1');

    const poMessages = await messageBus.getMessages(projectId, 'PO', testDir);
    expect(poMessages).toHaveLength(1);
    expect(poMessages[0].Message).toBe('Msg 2');
  });

  test('getMessages should return an empty array if project context does not exist', async () => {
    const messages = await messageBus.getMessages('non-existent', 'PO', testDir);
    expect(messages).toEqual([]);
  });
});
