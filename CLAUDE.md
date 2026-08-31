<!-- packwiz-tui tooling (auto-maintained, do not edit between markers) -->
## packwiz-tui tooling

This pack is managed with packwiz-tui, which is on PATH here. Useful commands
(run from the pack directory; they find pack.toml automatically):

- `packwiz-tui test server` — install + boot this pack's server, verify it reaches "Done", sample TPS over RCON. Fails with log paths on crash.
- `packwiz-tui test full [--soak 90s]` — the above plus a real headless client (gamescope + portablemc, offline account) that auto-joins, soaks in spectator, samples TPS, and saves screenshots to `.packwiz-tui/last-test/` — read those screenshots to check for visual problems.
- `packwiz-tui fix-sources` — find CurseForge-API-blocked mods (breaks unattended installs) and swap them to byte-identical Modrinth files. Doubles as an install test.
- `packwiz-tui tag-sides <server-pack.zip>` — set side=client/both on all mods by diffing an official server pack.
- `packwiz` itself (add/remove/update/refresh) is also on PATH.

Test artifacts and server/client state live under `.packwiz-tui/` (gitignored). Logs on failure: `.packwiz-tui/test-server/harness-console.log`, `.packwiz-tui/test-client/logs/latest.log`.
<!-- packwiz-tui tooling (auto-maintained, do not edit between markers) -->
