const trelloService = require('../src/trelloService');

// Mock global fetch for testing
global.fetch = jest.fn();

describe('trelloService', () => {
  const mockKey = 'test-key';
  const mockToken = 'test-token';

  beforeEach(() => {
    process.env.TRELLO_API_KEY = mockKey;
    process.env.TRELLO_TOKEN = mockToken;
    jest.clearAllMocks();
  });

  test('fetchBoard should return board data on success', async () => {
    const mockBoard = { id: 'b1', name: 'Test Board' };
    global.fetch.mockResolvedValue({
      ok: true,
      json: async () => mockBoard
    });

    const result = await trelloService.fetchBoard('b1');
    expect(result).toEqual(mockBoard);
    expect(global.fetch).toHaveBeenCalledWith(
      expect.stringContaining('https://api.trello.com/1/boards/b1')
    );
  });

  test('createTask should post a new card', async () => {
    const mockCard = { id: 'c1', name: 'Task 1' };
    global.fetch.mockResolvedValue({
      ok: true,
      json: async () => mockCard
    });

    const result = await trelloService.createTask('l1', 'Task 1', 'Desc');
    expect(result).toEqual(mockCard);
    expect(global.fetch).toHaveBeenCalledWith(
      expect.stringContaining('https://api.trello.com/1/cards'),
      expect.objectContaining({ method: 'POST' })
    );
  });

  test('should throw error if fetch fails', async () => {
    global.fetch.mockResolvedValue({
      ok: false,
      statusText: 'Unauthorized'
    });

    await expect(trelloService.fetchBoard('b1')).rejects.toThrow('Trello API error: Unauthorized');
  });
});
