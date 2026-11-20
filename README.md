# Blort plugins

Plugins that connect AI assistants to [Blort](https://getblort.com) and add skills for researching and writing video content.

| Client | Folder | Install |
| --- | --- | --- |
| Claude Code | [`claude/`](claude) | `/plugin marketplace add blort-ai/plugins`, then `/plugin install blort@blort` |
| Codex | [`claude/`](claude) | `codex plugin marketplace add blort-ai/plugins`, then `codex plugin add blort@blort` |
| ChatGPT | [`chatgpt/`](chatgpt) | Upload `chatgpt/blort-chatgpt-plugin-v<version>.zip` |

All of them use the Blort MCP server at `https://api.getblort.com/mcp` and sign in with your Blort account. Codex installs the Claude Code plugin as it is; sign in with `codex mcp login blort`. Skills run as `/blort:analyze` in Claude Code and `$blort:analyze` in Codex.

## Development

The skills live in `claude/skills/`. `scripts/build-chatgpt.sh` builds the ChatGPT bundle from `chatgpt/plugin.json`, `chatgpt/mcp.json` and the Claude plugin's logo and skills. Bump the version in `claude/.claude-plugin/plugin.json` and `chatgpt/plugin.json` together.

MIT licensed.
