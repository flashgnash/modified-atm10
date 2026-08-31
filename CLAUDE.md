<!-- packwiz-tui tooling (auto-maintained, do not edit between markers) -->
## packwiz-tui tooling

This pack is managed with packwiz-tui, which is on PATH here. Useful commands
(run from the pack directory; they find pack.toml automatically):

- `packwiz-tui test server` — install + boot this pack's server, verify it reaches "Done", sample TPS over RCON. Fails with log paths on crash.
- `packwiz-tui test full [--soak 90s]` — the above plus a real headless client (gamescope + portablemc, offline account) that auto-joins, soaks in spectator, samples TPS, and saves screenshots to `.packwiz-tui/last-test/` — read those screenshots to check for visual problems.
- `packwiz-tui fix-sources` — find CurseForge-API-blocked mods (breaks unattended installs) and swap them to byte-identical Modrinth files. Doubles as an install test.
- `packwiz-tui tag-sides <server-pack.zip>` — set side=client/both on all mods by diffing an official server pack.
- `packwiz-tui export mmc|mrpack|curseforge|server|all` — build importable artifacts into `.packwiz-tui/build/`. The mmc zip imports into PrismLauncher and self-updates from this repo via a packwiz-installer pre-launch hook.
- `packwiz-tui install-prism` — write the self-updating instance straight into the local PrismLauncher (creates or refreshes; never touches worlds/options). User restarts Prism to see it.
- `packwiz-tui release [tag]` — export all + publish a GitHub release with gh (defaults to v<pack version>).
- `packwiz-tui init-workflow` — scaffold a GitHub Actions workflow: every push builds all artifacts (downloadable as workflow artifacts), and a v* tag push publishes them as a release.
- `packwiz` itself (add/remove/update/refresh) is also on PATH.

Test artifacts and server/client state live under `.packwiz-tui/` (gitignored). Logs on failure: `.packwiz-tui/test-server/harness-console.log`, `.packwiz-tui/test-client/logs/latest.log`.

One-time CI setup offer: if `.github/workflows/release.yml` does not exist
and there is no `workflow-offer` comment below this block, offer the user CI
setup (`packwiz-tui init-workflow` — builds artifacts on every push, releases
on v* tags) exactly once at the start of the session. Whatever they decide,
record it by appending `<!-- packwiz-tui: workflow-offer: accepted|declined YYYY-MM-DD -->`
on its own line directly after this block, so future agents don't ask again.
<!-- packwiz-tui tooling (auto-maintained, do not edit between markers) -->
<!-- packwiz-tui: workflow-offer: accepted 2026-08-31 -->
