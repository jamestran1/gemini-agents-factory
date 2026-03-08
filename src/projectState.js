const fs = require('fs');
const path = require('path');

const DEFAULT_MANIFEST = path.join(__dirname, '..', 'projects.json');

/**
 * Get the absolute path to the manifest file.
 * @param {string} manifestPath - Optional custom path.
 * @returns {string}
 */
function getManifestPath(manifestPath) {
  if (manifestPath) return manifestPath;
  
  // Handle extension path if available
  const root = process.env.GEMINI_EXTENSION_PATH || path.join(__dirname, '..');
  return path.isAbsolute(DEFAULT_MANIFEST) ? DEFAULT_MANIFEST : path.join(root, 'projects.json');
}

/**
 * Load projects from the manifest.
 * @param {string} manifestPath 
 * @returns {Promise<Array>}
 */
async function listProjects(manifestPath) {
  const filePath = getManifestPath(manifestPath);
  if (!fs.existsSync(filePath)) return [];
  
  const content = fs.readFileSync(filePath, 'utf8');
  if (!content || content.trim() === '') return [];
  
  try {
    const projects = JSON.parse(content);
    return Array.isArray(projects) ? projects : [];
  } catch (error) {
    return [];
  }
}

/**
 * Add a project to the manifest.
 * @param {string} id 
 * @param {string} name 
 * @param {string} manifestPath 
 */
async function addProject(id, name, manifestPath) {
  const filePath = getManifestPath(manifestPath);
  const projects = await listProjects(filePath);
  
  const newProject = {
    id,
    name,
    status: 'active',
    created_at: new Date().toISOString().replace('T', ' ').substring(0, 19)
  };
  
  projects.push(newProject);
  fs.writeFileSync(filePath, JSON.stringify(projects, null, 2), 'utf8');
  return newProject;
}

/**
 * Archive a project in the manifest.
 * @param {string} id 
 * @param {string} manifestPath 
 */
async function archiveProject(id, manifestPath) {
  const filePath = getManifestPath(manifestPath);
  const projects = await listProjects(filePath);
  
  const updatedProjects = projects.map(p => {
    if (p.id === id) {
      return { ...p, status: 'archived' };
    }
    return p;
  });
  
  fs.writeFileSync(filePath, JSON.stringify(updatedProjects, null, 2), 'utf8');
}

module.exports = {
  listProjects,
  addProject,
  archiveProject
};
