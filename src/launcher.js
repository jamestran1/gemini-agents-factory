const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const GEMINI_EXE = 'C:\\nvm4w\\nodejs\\gemini.ps1';

/**
 * Get project root path.
 * @returns {string}
 */
function getProjectRoot() {
  return process.env.GEMINI_EXTENSION_PATH || path.join(__dirname, '..');
}

/**
 * Get agent prompt path.
 * @param {string} agent 
 * @returns {string}
 */
function getAgentPromptPath(agent) {
  return path.join(getProjectRoot(), 'agents', `${agent}.md`);
}

/**
 * Start a foreground session.
 * @param {string} projectId 
 * @param {string} agent 
 */
async function startSession(projectId, agent) {
  const root = getProjectRoot();
  const promptPath = getAgentPromptPath(agent);
  
  if (!fs.existsSync(promptPath)) {
    throw new Error(`Agent prompt file not found: ${promptPath}`);
  }

  const launchCommand = `$Host.UI.RawUI.WindowTitle = 'FACTORY: ${agent} - ${projectId}' ; Clear-Host ; Write-Host '========================================' -ForegroundColor Cyan ; Write-Host '  GEMINI AGENT FACTORY: ${agent}' -ForegroundColor Cyan ; Write-Host '  Project: ${projectId}' -ForegroundColor Cyan ; Write-Host '========================================' -ForegroundColor Cyan ; $env:GEMINI_SYSTEM_MD = '${promptPath}' ; Set-Location '${root}' ; & '${GEMINI_EXE}'`;

  const ps = spawn('powershell.exe', ['-NoExit', '-Command', launchCommand], {
    detached: true,
    stdio: 'ignore'
  });

  ps.unref();
  return `Launched foreground session for ${agent} - ${projectId}`;
}

/**
 * Spawn a background agent task.
 * @param {string} projectId 
 * @param {string} agent 
 */
async function spawnAgent(projectId, agent) {
  const root = getProjectRoot();
  const promptPath = getAgentPromptPath(agent);

  if (!fs.existsSync(promptPath)) {
    throw new Error(`Agent prompt file not found: ${promptPath}`);
  }

  const launchCommand = `$env:GEMINI_SYSTEM_MD = '${promptPath}' ; Set-Location '${root}' ; & '${GEMINI_EXE}'`;

  const ps = spawn('powershell.exe', ['-NoProfile', '-WindowStyle', 'Minimized', '-Command', launchCommand], {
    detached: true,
    stdio: 'ignore'
  });

  ps.unref();
  return `Spawned background agent ${agent} for ${projectId}`;
}

module.exports = {
  startSession,
  spawnAgent
};
