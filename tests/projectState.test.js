const fs = require('fs');
const path = require('path');
const projectState = require('../src/projectState');

const testManifest = path.join(__dirname, 'test-projects.json');

describe('projectState', () => {
  beforeEach(() => {
    if (fs.existsSync(testManifest)) {
      fs.unlinkSync(testManifest);
    }
  });

  afterAll(() => {
    if (fs.existsSync(testManifest)) {
      fs.unlinkSync(testManifest);
    }
  });

  test('addProject should create a manifest and add a project', async () => {
    await projectState.addProject('test-id', 'Test Project', testManifest);
    const projects = JSON.parse(fs.readFileSync(testManifest, 'utf8'));
    expect(projects).toHaveLength(1);
    expect(projects[0]).toMatchObject({
      id: 'test-id',
      name: 'Test Project',
      status: 'active'
    });
  });

  test('listProjects should return an empty array if manifest does not exist', async () => {
    const projects = await projectState.listProjects(testManifest);
    expect(projects).toEqual([]);
  });

  test('listProjects should return all projects from the manifest', async () => {
    await projectState.addProject('p1', 'Project 1', testManifest);
    await projectState.addProject('p2', 'Project 2', testManifest);
    const projects = await projectState.listProjects(testManifest);
    expect(projects).toHaveLength(2);
    expect(projects[0].id).toBe('p1');
    expect(projects[1].id).toBe('p2');
  });

  test('archiveProject should update project status to archived', async () => {
    await projectState.addProject('p1', 'Project 1', testManifest);
    await projectState.archiveProject('p1', testManifest);
    const projects = await projectState.listProjects(testManifest);
    expect(projects[0].status).toBe('archived');
  });
});
