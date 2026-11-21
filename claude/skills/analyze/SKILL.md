---
name: analyze
description: Break down videos, posts or any link to see why they work and what to reuse
argument-hint: [video, post or page links]
---
Analyze these: $ARGUMENTS

If `$ARGUMENTS` has no link, ask the user which videos, posts or pages to analyze, and stop.

## Process every link with Blort
1. Call `autodetect_sources` once with every link (up to 20). Use `analysisDepth: "full"` for short videos (TikTok, Reels, Shorts) and for Instagram carousels, so Blort captures what is on screen as well as what is said. Use the default `"audio"` for long videos, podcasts and calls. Websites, PDFs and other files need no depth. Leave out `boardId` unless the user asked to save to a board: the sources are then analyzed on their own, not put on any board.
2. It waits up to 45 seconds and returns the finished sources in `results` and the rest in `pendingSourceIds`. Read the finished ones right away. For the pending ones, call `get_sources` with those `sourceIds` (it waits up to 45 seconds), and repeat while some are still pending, for up to 10 minutes in total.
3. Base everything on what Blort returns: the `text` (the transcript, or for a full analysis the scenes with what is shown and said), the `analysis` (hook, storytelling format and idea) when a full analysis has one, the metrics and the media. Never guess from a title, caption or thumbnail alone. If a Blort tool fails, tell the user what failed instead of filling the gap from web search or memory. Long content comes in parts: when a source's `content.nextOffset` is not null, call `get_sources` with that one source id and `offset` set to it.
4. To see the visuals yourself, call `get_sources` with one `sourceIds` entry and `images: true`. It returns the thumbnail, or up to four carousel slides per call (`imageOffset` continues). Do this for every carousel, and for a video when the visual hook or layout matters.
5. If a link fails or stays pending, say which one and why (private, deleted, region-locked, still processing), and analyze the rest.
6. Answer in the user's language.

## One video or post
Use these sections, in this order:
- **Overview:** creator, platform, length, posted date, and views, likes, comments and shares. Give the engagement rate as (likes + comments + shares) / views. Instagram often returns no views or shares for a post; then give likes and comments, and say once that engagement rate isn't available.
- **Topic and angle:** what it is about in one sentence, the angle it takes, and the common belief it challenges, if any.
- **Hook** (first 1–3 seconds, or the first slide):
  - Spoken hook: the exact opening line.
  - Visual hook: what is on screen and what moves.
  - Text hook: on-screen text, if any.
  - Hook type: curiosity gap, bold claim, contrarian take, relatable pain, result first, list, question, or another you name.
  - Hook formula: the hook as a fill-in-the-blank template the user can reuse, for example "I tried [thing] for [time] so you don't have to".
  - Why it stops the scroll, in one or two lines.
- **Format:** talking head, voiceover with b-roll, skit, tutorial, listicle, green screen, carousel, and so on.
- **Structure:** the beats in order with timestamps (hook, setup, value or tension, payoff, call to action). Under each beat, quote the part of the transcript that belongs to it. Note how it keeps people watching: open loops, re-hooks, pacing.
- **Visual layout:** framing, setting, caption style, editing pace, b-roll, graphics, music or sound.
- **What to reuse:** 3–5 concrete takeaways, including one adapted hook for the user's niche if you know it.

For a long video, podcast, article or PDF, replace Hook, Format and Visual layout with **Key points** and **Best moments to clip** (timestamps and a one-line reason each).

## Several links
1. A table with one row per item: creator, format, topic, hook (one line), length, views, engagement rate.
2. **Patterns:** what they share across hooks, formats, structure, length and visuals, and which patterns line up with the best performers.
3. **Outliers:** anything one item does differently that seems to matter.
4. **What to reuse:** 3–5 takeaways from the whole set, with two or three hook formulas.

Skip full transcripts here unless the user asks; quote the opening lines instead.

## Keep the research
Offer once, at the end, to save the analyzed items to a Blort board, where the user can come back to them and chat with them in Blort. If they say yes, use the board they name (find it with `list_boards`) or create one with `create_board`, then call `autodetect_sources` again with the same links, the same `analysisDepth`, that `boardId` and, for several links, the `sourceGroupId` of a group named for what they are, made first with `create_source_group`. Blort reuses the analyses it already has. Link the board as https://app.getblort.com/board/<boardId>.
