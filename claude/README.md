# Blort

Analyze any video or link, find what's going viral, break down creators, and write scripts from your research.

This plugin connects Claude to the Blort MCP server at https://api.getblort.com/mcp and adds these skills:

- `analyze`: break down videos, posts, websites or PDFs: hook and its reusable formula, format, structure with transcript, visuals, and what to reuse.
- `viral`: find what's going viral in a niche from Blort's viral library or a live TikTok, Instagram or YouTube search, and the patterns behind it.
- `creator`: break down what a creator posts, what performs best, and what to borrow.
- `script`: write a video script grounded in a Blort board or in videos that worked.
- `start`: see what Blort can do and your recent boards.

It requires a Blort account; most tools need an active subscription.

Install in Claude Code:

```
/plugin marketplace add blort-ai/plugins
/plugin install blort@blort
```

Then run a skill as `/blort:analyze <link>`.

Codex installs the same plugin:

```
codex plugin marketplace add blort-ai/plugins
codex plugin add blort@blort
codex mcp login blort
```

Then run a skill as `$blort:analyze <link>`.

- Website: https://getblort.com
- Support: https://getblort.com/contact-us
- Privacy policy: https://getblort.com/privacy-policy
- Terms: https://getblort.com/terms-conditions
