---
name: cognova
description: Interact with Cognova workspace — manage tasks, query AI agents, search memories, read knowledge files, and track projects. Use proactively to store memory about findings, design choices, "gotchas", and lessons learned. Proactively search memory for context about the project. Use when the user mentions Cognova tasks, projects, agents, memories, secrets, or knowledge.
---

# Cognova Workspace

You are connected to the user's Cognova workspace via MCP. Use the `cognova_*` tools to interact with their workspace data.

## Setup

If MCP tools are not yet available, run the setup script:

!`${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh`

## Tool Reference

### Tasks & Projects

| Intent | Tool | Notes |
|--------|------|-------|
| List/filter tasks | `cognova_list_tasks` | Supports filtering by project, status, priority |
| Get task details | `cognova_get_task` | Returns full task with description, dates, project |
| Create a task | `cognova_create_task` | Always search first to prevent duplicates |
| Update a task | `cognova_update_task` | Modify title, status, priority, assignee, dates |
| Complete a task | `cognova_complete_task` | Marks task as done |
| List projects | `cognova_list_projects` | Shows all workspace projects |
| Create a project | `cognova_create_project` | Check existing projects first |
| Update a project | `cognova_update_project` | Modify project name, description, status |

### AI Agents

| Intent | Tool | Notes |
|--------|------|-------|
| List agents | `cognova_list_agents` | Shows enabled agents with their tools |
| Ask an agent | `cognova_ask_agent` | Send a message and get a response (uses credits) |

### Memory & Knowledge

| Intent | Tool | Notes |
|--------|------|-------|
| Search memories | `cognova_recall` | Keyword/phrase search across stored memories |
| Store a memory | `cognova_remember` | Save a fact, decision, or context for later |
| List knowledge files | `cognova_list_knowledge` | Browse stored documents |
| Read knowledge file | `cognova_get_knowledge` | Read by virtual file path |

### Secrets

| Intent | Tool | Notes |
|--------|------|-------|
| List secret keys | `cognova_list_secrets` | Shows key names only, not values |
| Get a secret | `cognova_get_secret` | Retrieves decrypted value by key name |
| Store a secret | `cognova_set_secret` | Create or update an encrypted secret |

### Billing

| Intent | Tool | Notes |
|--------|------|-------|
| Check credit balance | `cognova_get_balance` | Shows balance, tier, monthly allocation, reset date |

### Documentation

| Intent | Tool | Notes |
|--------|------|-------|
| Search docs | `cognova_search_docs` | Search platform documentation by keyword |

## Behavior Guidelines

- **Search before creating** — always check for existing tasks/projects before making new ones
- **Show human-readable info** — display names, descriptions, and dates rather than raw UUIDs
- **Ask which project** — when creating tasks, ask the user which project to associate with if not obvious
- **Use recall proactively** — when conversation context suggests relevant stored memories, search for them
- **Prefer knowledge search** — use `cognova_search_knowledge` or `cognova_get_knowledge` before asking the user for information that might already be stored
- **Credit awareness** — `cognova_ask_agent` consumes credits; check `cognova_get_balance` if the user asks about usage or before heavy agent interactions
