---
name: start
description: See what Blort can do and which account and boards are connected
---
Show what Blort can do for me.

1. Call `list_boards` with `limit: 5` to confirm the connection and see the user's recent boards. If it fails because the user is not signed in, tell them to connect Blort again.
2. In a few lines, say what Blort does in this chat. Each item is a skill of this plugin; name it the way this client runs skills (for example `/blort:analyze` in Claude Code, `$blort:analyze` in Codex), or just say the user can ask in their own words:
   - **analyze:** any video, post, website or PDF: hooks, format, structure, visuals and what to reuse.
   - **viral:** what's going viral in a niche, from Blort's viral library or a live TikTok, Instagram or YouTube search.
   - **creator:** what a creator posts, what performs best, what to borrow.
   - **script:** scripts written from the user's research or from videos that worked.
   - **Boards:** everything can be saved to a Blort board at https://app.getblort.com, where the user can chat with it.
3. List the recent boards by name, with links as https://app.getblort.com/board/<boardId>.
4. Suggest one concrete first step, such as pasting a video link to analyze.

Some tools need an active Blort subscription. If a tool says so, pass its message on, including the link to subscribe.
