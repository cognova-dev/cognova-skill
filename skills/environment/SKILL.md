---
name: environment
description: Check Cognova connection status, workspace health, and plan info. Use when the user asks if everything is working, wants to check their setup, or runs /environment.
---

# Environment Check

Verify the Cognova workspace connection and show status.

## Steps

1. **Check MCP connection** — run `claude mcp list` via Bash and confirm `cognova` is listed
2. **If MCP is not configured**, tell the user to set it up:
   ```bash
   claude mcp add cognova https://cognova.dev/mcp \
     --transport http \
     --header "Authorization: Bearer cg_YOUR_KEY"
   ```
   Direct them to https://cognova.dev/settings/api-keys to get a key.
3. **If MCP is configured**, call these tools and display results:
   - `cognova_get_balance` — show plan tier, credit balance, monthly allocation, reset date
   - `cognova_list_agents` — count enabled agents
   - `cognova_list_tasks` — count active tasks
   - `cognova_list_projects` — count projects

## Output Format

Display a clean summary table:

```
=== Cognova Status ===

Connection:   Connected (cognova.dev)
Plan:         {tier}
Credits:      {balance} / {monthly} (resets {date})
Agents:       {count} enabled
Tasks:        {count} active
Projects:     {count}
```

If any MCP call fails, report the error and suggest the user check their API key.

## Natural Language Patterns

- "Is everything working?" -> run this check
- "Check my setup" -> run this check
- "Am I connected?" -> run this check
- "What's my balance?" -> just call `cognova_get_balance`
