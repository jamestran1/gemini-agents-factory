const launcher = require('../src/launcher');
const { spawn } = require('child_process');

// Mock child_process.spawn
jest.mock('child_process', () => ({
  spawn: jest.fn()
}));

describe('launcher', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  test('startSession should spawn a new powershell process with correct arguments', async () => {
    spawn.mockReturnValue({ unref: jest.fn() });

    await launcher.startSession('test-proj', 'master');

    expect(spawn).toHaveBeenCalledWith(
      'powershell.exe',
      expect.arrayContaining(['-NoExit', '-Command']),
      expect.objectContaining({
        detached: true,
        stdio: 'ignore'
      })
    );
  });

  test('spawnAgent should spawn a minimized powershell process', async () => {
    spawn.mockReturnValue({ unref: jest.fn() });

    await launcher.spawnAgent('test-proj', 'software_engineer');

    expect(spawn).toHaveBeenCalledWith(
      'powershell.exe',
      expect.arrayContaining(['-WindowStyle', 'Minimized']),
      expect.objectContaining({
        detached: true,
        stdio: 'ignore'
      })
    );
  });
});
