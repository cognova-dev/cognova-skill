#!/usr/bin/env bash
set -euo pipefail

# Cognova MCP Setup
# Configures the MCP connection to your Cognova workspace.

COGNOVA_URL="${COGNOVA_URL:-https://cognova.dev/mcp}"

echo "=== Cognova MCP Setup ==="
echo ""

# Check if already configured
if claude mcp list 2>/dev/null | grep -q "cognova"; then
  echo "Cognova MCP server is already configured."
  echo "To reconfigure, run: claude mcp remove cognova && ${CLAUDE_SKILL_DIR:-$0}/scripts/setup.sh"
  exit 0
fi

# Get API key
echo "You need a Cognova API key to connect."
echo "Get one at: https://cognova.dev/settings/api-keys"
echo ""
read -rp "Enter your Cognova API key: " API_KEY

if [[ -z "$API_KEY" ]]; then
  echo "Error: API key is required."
  exit 1
fi

# Configure MCP server
claude mcp add cognova "$COGNOVA_URL" \
  --transport http \
  --header "Authorization: Bearer $API_KEY"

echo ""
echo "Cognova MCP server configured successfully."
echo "Available tools: cognova_list_agents, cognova_list_tasks, cognova_recall, and more."
echo "Try: /cognova or ask about your tasks, agents, or knowledge."
