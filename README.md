# Cognova Skill

Connect your coding agent to [Cognova](https://cognova.dev) — manage tasks, query AI agents, search memories, read knowledge files, and track projects from your editor.

Works with **Claude Code**, **Cursor**, **GitHub Copilot**, **Codex CLI**, **Gemini CLI**, and [40+ other agents](https://skills.sh).

## Install

### Claude Code (recommended)

```bash
npx skills add cognova/cognova-skill
```

Then run the setup when prompted to configure your API key.

### Claude Code Plugin

```bash
/plugin marketplace add cognova/cognova-skill
/plugin install cognova@cognova
```

### Claude Code MCP (manual)

```bash
claude mcp add cognova https://cognova.dev/mcp \
  --transport http \
  --header "Authorization: Bearer YOUR_API_KEY"
```

### Cursor / Windsurf / Other MCP Clients

Add to your MCP config (`.cursor/mcp.json`, etc.):

```json
{
  "mcpServers": {
    "cognova": {
      "url": "https://cognova.dev/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
    }
  }
}
```

## Get Your API Key

1. Go to [cognova.dev/settings/api-keys](https://cognova.dev/settings/api-keys)
2. Create a new API key
3. Copy the key (starts with `cg_`)

## What You Can Do

| Category | Tools | Access |
|----------|-------|--------|
| **Tasks** | List, create, update, complete tasks | Read: Free / Write: Starter+ |
| **Projects** | List, create, update projects | Read: Free / Write: Starter+ |
| **Agents** | List agents, ask agents questions | Read: Free / Invoke: Starter+ |
| **Memory** | Search and store memories | Read: Free / Write: Starter+ |
| **Knowledge** | List and read knowledge files | Free |
| **Secrets** | List, get, set encrypted secrets | List: Free / Read/Write: Starter+ |
| **Docs** | Search platform documentation | Free |

## How It Works

This skill follows the [Agent Skills](https://agentskills.io) open standard. It provides:

- **SKILL.md** — Instructions that tell your agent when and how to use Cognova tools
- **MCP Server** — The actual tool endpoints hosted at `cognova.dev/mcp` using [Streamable HTTP](https://modelcontextprotocol.io/specification/2025-03-26/basic/transports#streamable-http) transport
- **Setup script** — Configures the MCP connection with your API key

The skill teaches the agent to proactively use Cognova tools — searching memories for context, checking tasks before creating duplicates, and storing findings as memories for future sessions.

## CLAUDE.md Snippet

If you want to reinforce Cognova usage in your project, add this to your `CLAUDE.md`:

```markdown
## Cognova Integration

This project uses Cognova for task management, knowledge, and agent queries.
MCP server configured — use cognova_* tools for workspace interaction.
Proactively store design decisions and findings as memories with cognova_remember.
Search memories with cognova_recall before asking about project context.
```

## Protocol Details

- **Transport:** Streamable HTTP (MCP spec 2025-06-18)
- **Endpoint:** `POST/GET/DELETE https://cognova.dev/mcp`
- **Auth:** Bearer token via `Authorization` header
- **Sessions:** Server-side, 30-minute idle timeout
- **Session ID:** Returned in `Mcp-Session-Id` response header

## Links

- [Cognova](https://cognova.dev) — Platform
- [API Keys](https://cognova.dev/settings/api-keys) — Get your key
- [Tool Reference](references/tools.md) — Full tool documentation
- [Agent Skills Spec](https://agentskills.io) — Open standard
- [MCP Protocol](https://modelcontextprotocol.io) — Model Context Protocol

## License

MIT
