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
- Otherwise call `search_profiles` with the name or handle, on the platform the user named (try TikTok, Instagram and YouTube if they didn't). If several profiles match, pick the exact handle or the verified one with the most followers, and say which you picked.

## Collect their videos
1. Call `add_profile_to_board` with the profile link, `videoAmount: 12`, `sorting: "popular"` (`"views"` on Instagram) and `analysisDepth: "full"`. Use the board the user names (find it with `list_boards`) or create one named after the creator with `create_board`. If the user asked about recent content, use `sorting: "latest"` or a `startDate`.
2. The group fills in the background (usually 1–2 minutes), then Blort analyzes each video. Call `get_source_group` with `wait: true`, which waits up to 45 seconds for it to finish, and repeat while it is still `pending` or has pending sources, for up to 10 minutes in total. Then read the finished videos with `get_sources`, using their `boardSourceId`s as `ids`, several per call.
3. If some videos are still processing at the end, work with the finished ones and say how many are pending.

## Answer
Instagram often returns no views or shares for a post. When views are missing, rank by likes and comments instead, and say once that engagement rate isn't available for those posts.
Answer in the user's language:
- **Snapshot:** who they are, platform, followers, niche, and how often they post.
- **What they make:** their recurring formats and series, and the topics they return to.
- **Their hooks:** the 3–4 hook types they lean on, each with a fill-in-the-blank formula and an example opening line.
- **What performs best:** their top 3 videos by views and by engagement rate, (likes + comments + shares) / views, and what those have in common that the rest don't.
- **What to borrow:** 3–5 concrete things the user can apply to their own content.

When the client can show an artifact or canvas, present this as a clean visual page with the creator's top videos as cards (thumbnail, metrics, link). To see thumbnails or carousel slides yourself, use `get_sources` with one id and `images: true`.

Link the board as https://app.getblort.com/board/<boardId>; the user can chat with the creator's videos there.
