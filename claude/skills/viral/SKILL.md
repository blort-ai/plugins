---
name: viral
description: Find what's going viral in a niche and the hooks and formats behind it
argument-hint: [niche or topic, optional platform]
---
Find what's going viral for: $ARGUMENTS

If `$ARGUMENTS` is empty, ask the user for a niche or topic, and stop.

Base every number, quote and claim about a video or creator on what the Blort tools return. If a Blort tool fails or finds nothing, tell the user what you tried and what failed instead of filling the gap from web search or memory.

Finding videos adds nothing to a board. Put things on a board only if the user asks.

## Find the videos
1. **Blort's viral library first.** It is already collected and ranked, so it is fast, and many hits are already analyzed.
   - Call `list_viral_topics` (with the `platform`, if the user named one) and pick the codes that match the niche.
   - If a topic matches, call `list_viral_content` with that `topicCode`, `sort: "outlierScore"`, `daysAgo: 90` unless the user gave a period, the `platform` if they named one (`tiktok`, `instagram`, `youtube`), and `limit: 10`. Hits without an outlier score come after the scored ones in no useful order, so if the first page has few scores, call it again with `sort: "views"` or `sort: "engagement"`. Page with `nextCursor` while the hits stay strong, up to about 30.
   - If no topic matches, pass the niche as `query` instead (`sort` doesn't apply with `query`, and a query search can be slow, so keep `limit: 10` and set `platform` when you can).
   - If the period returns nothing, widen `daysAgo` to 365 and say the library has nothing more recent.
   - Each hit has the creator's username as `account`, its `link`, `description` (the caption), `thumbnailUrl`, `postedAt`, `viewCount`, `likeCount`, `commentCount` and `shareCount`. `outlierScore`, when present, is its views divided by the creator's average views: above 3 is a clear outlier. A hit with `sourceId` already has a full Blort analysis and carries its `hookCategory`, `spokenHook` and `formatCategory`.
2. **Live search when the library is thin** or the user wants today's results from one platform: `search_tiktok_videos` (`sort: "likes"`, `postedWithin: "month"`), `search_instagram_reels` (`sort: "views"`, `postedWithin: "month"`) or `search_youtube_videos` (`sort: "views"`, `postedWithin: "month"`, and `language` if the user's niche is in one), each with `limit: 20` and the niche as `query`. They return `items` with `link`, `author`, `caption`, `postedAt`, `views`, `likes`, `comments`, `shares` (TikTok only), `durationSeconds` and `thumbnailUrl`, but no transcript and no outlier score. Instagram returns at most one reel per creator. Results come in one batch; to see more, search again with different words.
3. Views alone favor big accounts. When a live result looks strong, you can check it against the creator's usual: `get_tiktok_profile`, `get_instagram_profile` or `get_youtube_profile` with the creator's profile link (find it with `search_profiles` and the result's `author`) returns their `averageViews` in `profile`. Do this for a few standouts, not every result.

## Analyze the top 5–10
Instagram often returns no views or shares for a post. When views are missing, rank by likes and comments instead, and say once that engagement rate isn't available for those posts.
1. Pick the 5–10 strongest videos by `outlierScore` when present, otherwise by views relative to their age, and by engagement rate, (likes + comments + shares) / views.
2. Read the ones with a `sourceId` with one `get_sources` call `{ "sourceIds": [...] }`. Their analysis is already done, so this is instant and spends nothing.
3. Pass the links of the rest to `autodetect_sources` in one call, each with `analysisDepth: "full"`, and without `boardId`. Read the `results` that finished; for any in `pendingSourceIds`, call `get_sources` with those `sourceIds`; it waits up to 45 seconds for them. After about 5 minutes, work with what has finished and say how many are still processing.
4. To compare thumbnails or carousel slides, use `get_sources` with one source id and `images: true`.

## Answer
Answer in the user's language:
1. **What's working:** 3–5 patterns, strongest first. For each, name the hook type and give its fill-in-the-blank formula, the format, the typical length, and 2–3 example videos with creator, link, views, engagement rate and outlier score when there is one.
2. **Topics with momentum:** the subjects or angles that keep coming back, and one that looks underused.
3. **Ideas for the user:** 3 video ideas that apply these patterns to their niche, each with an opening line.

When the client can show an artifact or canvas, present this as a clean visual page with a card per video (its `thumbnailUrl`, creator, metrics, link). Lead with the patterns, then the videos that support them.

## Keep the research
Offer once, at the end, to save the analyzed videos to a Blort board, where the user can come back to them and chat with them. If they say yes, use the board they name (find it with `list_boards`) or create one with `create_board`, then call `autodetect_sources` with the videos' links, `analysisDepth: "full"`, that `boardId` and the `sourceGroupId` of a group named after the niche, made first with `create_source_group`. Blort reuses the analyses it already has. Link the board as https://app.getblort.com/board/<boardId>.
