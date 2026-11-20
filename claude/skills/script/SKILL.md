---
name: script
description: Write a video script grounded in your Blort research or in videos that worked
argument-hint: [topic, plus a board name or reference links]
---
Write a video script for: $ARGUMENTS

If `$ARGUMENTS` has no topic, ask what the video should be about, and stop.

Take every fact, number and example you cite from what the Blort tools return or what the user gave you. If a Blort tool fails or finds nothing, say so instead of filling the gap from web search or memory.

## Gather the research
Use what the user gives you, in this order:
1. **A Blort board:** find it with `list_boards`, list its items with `list_sources_for_board`, and read the relevant ones with `get_sources`. Boards often hold the user's own past videos, notes and documents: use them for their voice, facts and offers.
2. **Reference links:** process them with `autodetect_sources` (`analysisDepth: "full"` for short videos) and read what comes back. Analysis can take a few minutes; if it hasn't finished after about 5, write from what you have and say so.
3. **Nothing given:** find strong examples with `list_viral_content`: call `list_viral_topics` and, if a topic fits, use its `topic_code` with `sort_by: "outlierScore"`; otherwise pass the topic as `query`. Keep `limit: 10` and set `platform` when the user named one. Keep the 3–5 hits with the most views. A hit with `sourceId` already has a full analysis you can read with `get_sources`.

Base the script on that research: borrow structures and hook types that worked, not wording. Never copy another creator's lines.

## Write
Ask nothing more unless the platform or length is unclear and matters. Default to a 30–45 second vertical video. Answer in the user's language and in their voice if the board shows it.

1. **Three hooks** to choose from, each a different hook type, each with what is on screen and any on-screen text.
2. **The script** for the strongest hook, in beats with rough timestamps: hook, setup, value, payoff, call to action. Give each beat the spoken line and a short visual direction (shot, b-roll, text on screen).
3. **Why it should work:** two or three lines tying the choices to the research, naming the example videos.
4. **Caption** and up to five hashtags.

## Keep it
If the research came from a board, offer to save the script to it with `create_source_text` and the board's `boardId`, and link the board as https://app.getblort.com/board/<boardId>.
