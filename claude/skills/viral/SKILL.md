---
name: viral
description: Find what's going viral in a niche and the hooks and formats behind it
argument-hint: [niche or topic, optional platform]
---
Find what's going viral for: $ARGUMENTS

If `$ARGUMENTS` is empty, ask the user for a niche or topic, and stop.

Base every number, quote and claim about a video or creator on what the Blort tools return. If a Blort tool fails or finds nothing, tell the user what you tried and what failed instead of filling the gap from web search or memory.

## Find the videos
1. **Blort's viral library first.** It is already collected and ranked, so it is fast.
   - Call `list_viral_topics` (with the `platform`, if the user named one) and pick the codes that match the niche.
   - If a topic matches, call `list_viral_content` with that `topic_code`, `sort_by: "outlierScore"`, `days_ago: 90` unless the user gave a period, the `platform` if they named one, and `limit: 10`. Page with `nextCursor` while the hits stay strong, up to about 30.
   - If no topic matches, pass the niche as `query` instead (`sort_by` doesn't apply with `query`, and a query search can be slow, so keep `limit: 10` and set `platform` when you can).
   - If the period returns nothing, widen `days_ago` to 365 and say the library has nothing more recent.
   - Each hit has the creator's username as `account`, its link, caption, `text`, `thumbnailUrl` and metrics. `outlierScore`, when present, is its views divided by the creator's average views: above 3 is a clear outlier. A hit with `sourceId` already has a full Blort analysis: read it with `get_sources` `{ "sourceIds": [...] }` instead of processing the link again.
2. **Live search when the library is thin** or the user wants today's results from one platform: `search_tiktok_videos`, `search_instagram_reels` or `search_youtube_videos`. These add the results to a board, so use the board the user names (find it with `list_boards`) or create one named after the niche with `create_board`. The search fills the returned group in the background and Blort then processes each video: call `get_source_group` with `wait: true` (it waits up to 45 seconds) until it is done, and read finished videos with `get_sources` using their `boardSourceId`s as `ids`. After about 5 minutes, work with what has finished and say how many are still processing.

## Analyze the top 5–10
Instagram often returns no views or shares for a post. When views are missing, rank by likes and comments instead, and say once that engagement rate isn't available for those posts.
Pick the 5–10 strongest videos by `outlierScore` when present, otherwise by views relative to their age, and by engagement rate, (likes + comments + shares) / views. For the ones without a transcript, pass their links to `autodetect_sources` with `analysisDepth: "full"`. To compare thumbnails or carousel slides, use `get_sources` with one id and `images: true`.

## Answer
Answer in the user's language:
1. **What's working:** 3–5 patterns, strongest first. For each, name the hook type and give its fill-in-the-blank formula, the format, the typical length, and 2–3 example videos with creator, link, views and engagement rate.
2. **Topics with momentum:** the subjects or angles that keep coming back, and one that looks underused.
3. **Ideas for the user:** 3 video ideas that apply these patterns to their niche, each with an opening line.

When the client can show an artifact or canvas, present this as a clean visual page with a card per video (its `thumbnailUrl`, creator, metrics, link). Lead with the patterns, then the videos that support them.

If the videos were added to a board, link it as https://app.getblort.com/board/<boardId> and say the user can chat with them there.
