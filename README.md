# Blort plugins

Plugins that connect AI assistants to [Blort](https://getblort.com) and add skills for researching and writing video content.

| Client | Folder | Install |
| --- | --- | --- |
| Claude Code | [`claude/`](claude) | `/plugin marketplace add blort-ai/plugins`, then `/plugin install blort@blort` |
| Codex | [`claude/`](claude) | `codex plugin marketplace add blort-ai/plugins`, then `codex plugin add blort@blort` |
| ChatGPT | [`chatgpt/`](chatgpt) | Upload `chatgpt/blort-chatgpt-plugin-v<version>.zip` |

All of them use the Blort MCP server at `https://api.getblort.com/mcp` and sign in with your Blort account. Codex installs the Claude Code plugin as it is; sign in with `codex mcp login blort`. Skills run as `/blort:analyze` in Claude Code and `$blort:analyze` in Codex.

The skills find videos with Blort's viral library (`list_viral_content`), live searches (`search_tiktok_videos`, `search_instagram_reels`, `search_youtube_videos`) and creator profiles (`search_profiles`, `get_<platform>_profile`), none of which change a board. They analyze links with `autodetect_sources` and read the results with `get_sources`, reusing Blort's existing analysis when a hit has a `sourceId`. They pass a `boardId` only when the user asks to save to a board.

## Development

The skills live in `claude/skills/`. `scripts/build-chatgpt.sh` builds the ChatGPT bundle from `chatgpt/plugin.json`, `chatgpt/mcp.json` and the Claude plugin's logo and skills. Bump the version in `claude/.claude-plugin/plugin.json` and `chatgpt/plugin.json` together.

MIT licensed.
