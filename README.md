# 🏴‍☠️ One Piece: Grand Line Survival

**A One Piece pirate survival game starring Luffy. Battle waves of Marines, unlock seven weapons, and activate Gear 5—all in your browser.**

## [▶ Play One Piece: Grand Line Survival](https://hwangsukjoo101.github.io/Onepiece-vs-marines/?v=realistic-world)

### The adventure

Defend a wooden ship deck against endless Marine waves. Start with three lives, collect pink XP crystals to level up, and unlock pirate weapons from a Straw Hat flintlock to a golden Kizaru laser beam and Blackbeard’s Dark Hole, which absorbs and defeats up to four Marines per hit. Grab a meat feast for ten seconds of Gear 5 invincibility. From round 5, glowing ☢ nuke pickups clear all Marines on screen, award their kills and XP, and return after a 40-second cooldown.

Enter a username before setting sail. A shared Supabase leaderboard ranks all usernames by highest round, then Marine kills from that run. Names are matched without case sensitivity. Use Refresh for current standings and Load more to browse all players. The game-over screen shows a live top-ten leaderboard, highlights your username, and refreshes every five seconds until you sail again. Scores sync at each new round and at game over; failed submissions are kept in browser storage and retried when online. Older browser-only records remain visible locally and are not automatically uploaded.

### AI visual update

The world uses AI-generated realistic artwork: a weathered ship deck and ocean, detailed Luffy and Marine sprites, roast-meat and nuke pickups. Warm cinematic lighting, contact shadows, depth sorting, high-resolution canvas rendering, glowing weapon trails, and a brass-and-navy interface complete the look. The game remains a lightweight 2D canvas game, with no AI calls or API charges while playing.

Artwork is hosted in [assets/realistic](assets/realistic). [Generation prompts](assets/realistic/ARTWORK.md) describe the assets. Images load asynchronously with the original canvas artwork as a fallback, so unavailable art does not prevent play.

### Controls

- **WASD / arrows:** Move
- **Mouse:** Aim
- **Hold left click / X:** Shoot
- **1–7:** Switch unlocked weapons
- **P:** Pause

When the mouse is outside the arena, shooting targets the closest Marine. Touch controls are available on mobile.

### Shared leaderboard backend

Hosted on GitHub Pages with Supabase project `uhozfbmnnvlnzdlxvrrx`. The reproducible schema is in [supabase/leaderboard.sql](supabase/leaderboard.sql). The frontend uses only a public publishable key and the REST API; no SDK or privileged key is required.

RLS permits public reads and validated append-only score submissions. Public clients cannot edit or delete scores; the security-invoker ranking function picks each username's best run, so lower scores cannot replace it. Usernames are shared labels, not authenticated identities. Scores are client-reported: this casual leaderboard does not prevent impersonation or fabricated scores. Authenticated accounts and server-validated gameplay would be needed for competitive integrity.

An unofficial fan game. One Piece characters belong to their respective rights holders.
