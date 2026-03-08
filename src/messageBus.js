const fs = require('fs');
const path = require('path');

/**
 * Get the absolute path to the project context file.
 * @param {string} projectId 
 * @param {string} baseDir - Optional base directory.
 * @returns {string}
 */
function getContextFilePath(projectId, baseDir) {
  const root = baseDir || process.env.GEMINI_EXTENSION_PATH || path.join(__dirname, '..');
  return path.join(root, `shared_context_${projectId}.json`);
}

/**
 * Send a message to the project's shared context bus.
 * @param {string} projectId 
 * @param {string} from 
 * @param {string} to 
 * @param {string} message 
 * @param {string} baseDir 
 */
async function sendMessage(projectId, from, to, message, baseDir) {
  const filePath = getContextFilePath(projectId, baseDir);
  let messages = [];
  
  if (fs.existsSync(filePath)) {
    try {
      const content = fs.readFileSync(filePath, 'utf8');
      if (content && content.trim() !== '') {
        messages = JSON.parse(content);
        if (!Array.isArray(messages)) messages = [];
      }
    } catch (error) {
      messages = [];
    }
  }
  
  const newMessage = {
    Timestamp: new Date().toISOString().replace('T', ' ').substring(0, 19),
    From: from,
    To: to,
    Message: message
  };
  
  messages.push(newMessage);
  fs.writeFileSync(filePath, JSON.stringify(messages, null, 2), 'utf8');
}

/**
 * Retrieve messages for an agent from the context bus.
 * @param {string} projectId 
 * @param {string} to - Recipient role filter.
 * @param {string} baseDir 
 * @returns {Promise<Array>}
 */
async function getMessages(projectId, to, baseDir) {
  const filePath = getContextFilePath(projectId, baseDir);
  if (!fs.existsSync(filePath)) return [];
  
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    if (!content || content.trim() === '') return [];
    
    const messages = JSON.parse(content);
    if (!Array.isArray(messages)) return [];
    
    if (to) {
      return messages.filter(m => m.To === to);
    }
    return messages;
  } catch (error) {
    return [];
  }
}

module.exports = {
  sendMessage,
  getMessages
};
