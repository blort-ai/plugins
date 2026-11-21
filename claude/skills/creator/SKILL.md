---
name: creator
description: Break down what a creator posts, what performs best, and what to borrow
argument-hint: [creator handle, name or profile link]
---
Break down this creator: $ARGUMENTS

If `$ARGUMENTS` is empty, ask the user which creator, and stop.

Base every number, quote and claim about a video or creator on what the Blort tools return. If a Blort tool fails or finds nothing, tell the user what you tried and what failed instead of filling the gap from web search or memory.

## Find the profile
- If `$ARGUMENTS` is a profile link, use it.
- Otherwise call `search_profiles` with the name or handle, on the platform the user named (try TikTok, Instagram and YouTube if they didn't). If several profiles match, pick the exact handle or the verified one with the most followers, and say which you picked. Use its `profileUrl`.

## Read the profile
1. Call the tool for its platform: `get_tiktok_profile`, `get_instagram_profile`, `get_youtube_profile`, or `get_meta_ads_profile` for a Facebook Ad Library page. Pass the `link`, `sort: "top"` and `limit: 20`. On YouTube, add `format: "shorts"` unless the user asked about long videos (`"video"`). If the user asked about recent content, use `sort: "recent"` or `daysAgo`.
2. The first read of a profile fetches it live and the tool waits up to 45 seconds. If `status` is still `creating` or `extracting`, call it again, for up to about 5 minutes in total, then work with what it returned and say the profile was still loading.
3. The result has the creator's stats in `profile` (`followers`, `postsCount`, `averageViews`, `niche`, `targetAudience`, `topics`, `postingStreak`, `language`) and their posts in `items`, ranked as `rankedBy` says. `top` ranks by `outlierScore`, the post's views divided by the creator's average views: above 3 is a clear outlier. On Instagram, `top` ranks by likes instead. Each post has its link, `description`, `text` (the first 2,000 characters of its transcript or analysis, when Blort has one), `postedAt`, `viewCount`, `likeCount`, `commentCount`, `shareCount`, `videoLength` and `thumbnailUrl`.
4. To compare what performs with what they post now, also call the same tool with `sort: "recent"` and `limit: 10`. Blort has the profile by then, so this is quick.

Nothing is added to a board by reading a profile.

## Analyze their best posts
1. Pick the 8–10 posts at the top of the ranking, plus any recent post that stands out.
2. Posts with a `sourceId` already have a full Blort analysis: read them all with one `get_sources` call `{ "sourceIds": [...] }`. This is instant and spends nothing.
3. Pass the links of the rest to `autodetect_sources` in one call, each with `analysisDepth: "full"`. Leave out `boardId` unless the user asked to save to a board. Read the `results` that finished; for any in `pendingSourceIds`, call `get_sources` with those `sourceIds` and `wait: true`, and repeat while some are still pending, for up to 10 minutes in total.
4. If some videos are still processing at the end, work with the finished ones and say how many are pending.

## Answer
Instagram often returns no views or shares for a post. When views are missing, rank by likes and comments instead, and say once that engagement rate isn't available for those posts.
Answer in the user's language:
- **Snapshot:** who they are, platform, followers, average views, niche, target audience, and how often they post.
- **What they make:** their recurring formats and series, and the topics they return to.
- **Their hooks:** the 3–4 hook types they lean on, each with a fill-in-the-blank formula and an example opening line.
- **What performs best:** their top 3 videos by outlier score (how many times their average views each got) and by engagement rate, (likes + comments + shares) / views, and what those have in common that the rest don't. Say whether their recent posts follow the same pattern.
- **What to borrow:** 3–5 concrete things the user can apply to their own content.

When the client can show an artifact or canvas, present this as a clean visual page with the creator's top videos as cards (thumbnail, metrics, outlier score, link). To see thumbnails or carousel slides yourself, use `get_sources` with one source id and `images: true`.

## Keep the research
Offer once, at the end, to save the creator's top videos to a Blort board, where the user can come back to them and chat with them. If they say yes, use the board they name (find it with `list_boards`) or create one with `create_board`, then call `autodetect_sources` with the same links, `analysisDepth: "full"`, that `boardId` and the `sourceGroupId` of a group named after the creator's handle, made first with `create_source_group`. Blort reuses the analyses it already has. Link the board as https://app.getblort.com/board/<boardId>.
