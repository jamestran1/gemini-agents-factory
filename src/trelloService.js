/**
 * Get Trello API credentials from environment variables.
 * @returns {{key: string, token: string}}
 */
function getCredentials() {
  const key = process.env.TRELLO_API_KEY;
  const token = process.env.TRELLO_TOKEN;
  if (!key || !token) {
    throw new Error('TRELLO_API_KEY and TRELLO_TOKEN environment variables must be set.');
  }
  return { key, token };
}

/**
 * Fetch a Trello board's details.
 * @param {string} boardId 
 * @returns {Promise<Object>}
 */
async function fetchBoard(boardId) {
  const { key, token } = getCredentials();
  const url = `https://api.trello.com/1/boards/${boardId}?key=${key}&token=${token}`;
  
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`Trello API error: ${response.statusText}`);
  }
  
  return await response.json();
}

/**
 * Create a new card (task) on a Trello list.
 * @param {string} listId 
 * @param {string} name 
 * @param {string} description 
 * @returns {Promise<Object>}
 */
async function createTask(listId, name, description = '') {
  const { key, token } = getCredentials();
  const url = `https://api.trello.com/1/cards?key=${key}&token=${token}`;
  
  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      idList: listId,
      name: name,
      desc: description
    })
  });
  
  if (!response.ok) {
    throw new Error(`Trello API error: ${response.statusText}`);
  }
  
  return await response.json();
}

module.exports = {
  fetchBoard,
  createTask
};
