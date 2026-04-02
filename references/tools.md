# Cognova MCP Tool Reference

Complete reference for all Cognova MCP tools. Tools are workspace-scoped — all data is isolated to the authenticated workspace.

## Access Levels

| Level | Plan | Tools Available |
|-------|------|-----------------|
| Read | Free+ | List/get/search tools |
| Full | Starter+ | All read tools + create/update/delete/invoke |

## Tools

### cognova_list_agents

List all enabled agents in the workspace with their descriptions and tools.

**Parameters:**
- `enabled_only` (boolean, optional) — Only show enabled agents. Default: `true`

**Returns:** Array of agents with `id`, `name`, `description`, `modelTier`, `isDefault`, `enabled`, `tools[]`

---

### cognova_ask_agent

Send a message to a specific Cognova agent and get a response. The agent can use its tools (tasks, memory, knowledge, delegation) internally. **Consumes credits.**

**Parameters:**
- `agent_id` (string, required) — The agent ID to invoke
- `message` (string, required) — The message/question to send

**Returns:** Agent's text response

**Access:** Starter+ only

---

### cognova_list_tasks

List tasks in the workspace with optional filters.

**Parameters:**
- `project_id` (string, optional) — Filter by project ID
- `status` (string, optional) — Filter by: `todo`, `in_progress`, `done`, `blocked`
- `limit` (number, optional) — Max results. Default: 20

**Returns:** Array of task objects

---

### cognova_get_task

Get full details of a specific task by ID.

**Parameters:**
- `task_id` (string, required) — Task ID to retrieve

**Returns:** Full task object with title, description, status, priority, dates, project

---

### cognova_create_task

Create a new task in the workspace.

**Parameters:**
- `title` (string, required) — Task title
- `description` (string, optional) — Task description
- `project_id` (string, optional) — Project ID to assign to
- `priority` (number, optional) — 1=low, 2=medium, 3=high, 4=critical. Default: 2
- `due_date` (string, optional) — Due date in ISO format

**Returns:** Created task object

**Access:** Starter+ only

---

### cognova_update_task

Update an existing task.

**Parameters:**
- `task_id` (string, required) — Task ID to update
- `title` (string, optional) — New title
- `description` (string, optional) — New description
- `status` (string, optional) — `todo`, `in_progress`, `done`, `blocked`
- `priority` (number, optional) — 1-4
- `due_date` (string, optional) — ISO date or empty to clear

**Returns:** Updated task object

**Access:** Starter+ only

---

### cognova_complete_task

Mark a task as done.

**Parameters:**
- `task_id` (string, required) — Task ID to complete

**Returns:** Confirmation with task title

**Access:** Starter+ only

---

### cognova_list_projects

List all projects in the workspace.

**Parameters:**
- `status` (string, optional) — Filter by project status

**Returns:** Array of project objects

---

### cognova_create_project

Create a new project in the workspace.

**Parameters:**
- `name` (string, required) — Project name
- `description` (string, optional) — Project description

**Returns:** Created project object

**Access:** Starter+ only

---

### cognova_update_project

Update an existing project.

**Parameters:**
- `project_id` (string, required) — Project ID to update
- `name` (string, optional) — New name
- `description` (string, optional) — New description
- `status` (string, optional) — Project status (e.g. `active`, `archived`)

**Returns:** Updated project object

**Access:** Starter+ only

---

### cognova_recall

Search workspace memories by keyword or phrase.

**Parameters:**
- `query` (string, required) — Search query
- `type` (string, optional) — Filter by memory type
- `limit` (number, optional) — Max results. Default: 10

**Returns:** Array of memory objects with `id`, `type`, `content`, `createdAt`

---

### cognova_remember

Store a memory in the workspace knowledge base.

**Parameters:**
- `content` (string, required) — The content to remember
- `type` (string, optional) — Memory type: `fact`, `decision`, `solution`, `pattern`, `preference`, `summary`. Default: `fact`

**Returns:** Confirmation with memory ID

**Access:** Starter+ only

---

### cognova_list_knowledge

List available knowledge files in the workspace.

**Parameters:** None

**Returns:** Array of files with `id`, `path`, `title`, `mimeType`, `updatedAt`

---

### cognova_get_knowledge

Read the content of a knowledge file by its path.

**Parameters:**
- `path` (string, required) — Virtual path of the knowledge file

**Returns:** File content as text

---

### cognova_list_secrets

List all secret keys stored in the workspace (values are not shown).

**Parameters:** None

**Returns:** Array of secret metadata with `id`, `key`, `createdAt`, `updatedAt`

---

### cognova_get_secret

Get the decrypted value of a secret by its key name.

**Parameters:**
- `key` (string, required) — Secret key name (e.g. `OPENAI_API_KEY`)

**Returns:** Decrypted secret value

**Access:** Starter+ only

---

### cognova_set_secret

Create or update an encrypted secret in the workspace.

**Parameters:**
- `key` (string, required) — Secret key name in SCREAMING_SNAKE_CASE (e.g. `MY_API_KEY`)
- `value` (string, required) — The secret value to encrypt and store

**Returns:** Confirmation of creation or update

**Access:** Starter+ only

---

### cognova_get_balance

Get the current credit balance, plan tier, and reset date for this workspace.

**Parameters:** None

**Returns:** Object with `tier` (plan name), `creditBalance` (remaining credits), `monthlyCredits` (total monthly allocation), `creditsResetAt` (next reset date)

---

### cognova_search_docs

Search Cognova platform documentation by keyword.

**Parameters:**
- `query` (string, required) — Search query for docs

**Returns:** Array of matching docs with `slug`, `title`, `category`, `excerpt`

## MCP Resources

In addition to tools, the MCP server exposes these resources:

| URI | Description |
|-----|-------------|
| `cognova://tasks/active` | All non-completed tasks (JSON) |
| `cognova://knowledge/{path}` | Knowledge file by virtual path |
| `cognova://agents/{agentId}` | Agent details with tools |
| `cognova://docs` | Documentation table of contents |
| `cognova://docs/{slug}` | Individual doc page (markdown) |
