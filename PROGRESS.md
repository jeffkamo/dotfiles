# PROGRESS

Working/scratch tracking doc for the multi-env dotfiles restructure. Mirrors
the headings and numbering in the plan at
`/home/xunlee/.claude/plans/silly-sniffing-knuth.md` (also copied to
`/tmp/claude-1000/-home-xunlee-Work-dotfiles/a7b91c65-bce4-4bc7-a0d3-a903f66efe76/scratchpad/dotfiles-multi-env-plan.md`).
Safe to delete before this branch is merged to `main`. If you're a fresh
agent picking this up: read the plan doc first for full context/rationale,
then use this file to see what's actually done vs. still pending.

Branch: `feat/multi-env-dotfiles`. Nothing lands on `main` until the user
reviews and merges.

## 0. Prerequisite: bump the dotbot submodule
- [x] Bump `dotbot` submodule from `d2f76a25` (v1.19) to v1.24.1, commit gitlink
- [x] Confirmed `-c` accepts multiple files and `-n/--dry-run` exists in v1.24.1
- [x] Fixed `omarchy/themes/{aetheria,coppernight}` gitlinks — both were empty
      with no known upstream, `git rm --cached` rather than guessing a URL

**Superseded by §6.0 below** (a later plan rewrite removed the shared
`install.common.yaml`/`install.force.yaml` design entirely in favor of
fully self-contained per-env yamls). Kept here for history; §6.0 is the
authoritative current state.

## 1. Split `install.conf.yaml` into common + per-env dotbot configs
- [x] Write `install.common.yaml`
- [x] Write `install.omarchy3.yaml`
- [x] Write `install.omarchy4.yaml`
- [x] Write `install.fedora.yaml`
- [x] Write `install.mac.yaml`
- [x] Verify via `--dry-run` diff against old `install.conf.yaml` (omarchy3 path) —
      matches exactly plus the new lazygit line, as expected
- [x] Delete superseded `install.conf.yaml`

**Deviation from plan (approved via AskUserQuestion mid-execution):** kept
`nvim` and `gitconfig` OUT of `install.common.yaml`, matching today's
actual (commented-out) behavior rather than the plan's literal text —
`nvim` had an explicit "use Omarchy defaults" rationale in the old file
that the plan text seems to have missed; `gitconfig` just followed suit
for consistency. See git log for this branch around this point.

**Correction to plan's dotbot invocation:** the plan's example command
(`-c install.common.yaml -c install.omarchy.yaml`, repeated `-c` flags)
does NOT work — argparse's `store` action makes a second `-c` overwrite
the first rather than append, so only the last file's directives run.
Verified this empirically. Correct form: **one** `-c` flag with
space-separated files (`-c install.common.yaml install.omarchy3.yaml`).
This matters for the `install` script in §4 — don't repeat `-c`.

## 2. Move directory-based configs under nested per-env dirs
- [x] hypr: `git mv` top-level `hypr/*.conf` → `hypr/omarchy3/` (explicit files, not glob)
- [x] hypr: drop committed `.bak.*` junk during the move
- [x] hypr: seed `hypr/omarchy4/` from live `~/.config/hypr`
- [x] omarchy: `git mv` `omarchy/{branding,current,hooks,themes}` → `omarchy/omarchy3/`
- [x] omarchy: seed `omarchy/omarchy4/` from live `~/.config/omarchy`
- [x] ghostty: seed `ghostty/omarchy4/config` from live `~/.config/ghostty/config`
- [x] lazygit: create empty `lazygit/config.yml` baseline (matches live empty state)
- [x] waybar: left as-is (no fork needed yet) — confirmed still true (no v4 diff observed)
- [x] Verified all four envs (`omarchy3`, `omarchy4`, `fedora`, `mac`) resolve cleanly via
      `dotbot -n` (dry-run) — no "Nonexistent target" warnings, all sources exist.
      Note: dry-run prints "Would remove X" for real (non-symlink) targets
      unconditionally, regardless of `force` — that's a dry-run-only quirk (see
      `_delete()` in dotbot's link.py); the actual force-gate on a real run still
      applies, so finding #3 / rollout step 9 remain accurate. No files outside
      the repo were touched — confirmed via `stat` on all four live `~/.config`
      targets after every dry-run.

## 3. Port mac-specific files as flat `<name>.<env>` siblings
- [x] `zshrc.mac` from `temporary-mac-config` (byte-identical, diff-verified)
- [x] `tmux.mac.conf` from `temporary-mac-config` (byte-identical, diff-verified)
- [x] `lazygit.mac/config.yml` from `temporary-mac-config`, wired to macOS Application Support path
- [x] Skip `.bash_profile` (confirmed redundant)
- [x] Final full-file diff of `temporary-mac-config` vs `main` to confirm nothing else missed —
      clean; only other unaccounted item found was mac's old `install` script
      (pre-dates the run/ script split, superseded) except one real gap: it had
      `brew install worktrunk`, which run/macos was missing even though
      zshrc.mac and lazygit.mac both depend on `wt` — added to run/macos.
- [x] Leave `temporary-mac-config` branch in place (do not delete)

**Superseded by §6.0/6.1/6.4/6.5/6.6 below** — `--force` and
`install.force.yaml`/`DOTBOT_CONFIGS` composition no longer exist. Kept
for history.

## 4. `install` script: `-e/--env`, `--force`, `--clean`, env lock
- [x] Arg parsing (`-e/--env`, `--force`, `--clean`, `-h/--help`)
- [x] Usage/error when `-e` missing or unknown env
- [x] `.installed-env` write-after-success + read-and-compare guard
- [x] `.gitignore` added (`.installed-env`, `.DS_Store`, `*.bak.*`)
- [x] `--clean` symlink-scan implementation
- [x] Guard message text matches plan

**Implementation note:** `--force` can't be a bare `defaults: {link:
{force: true}}` override — dotbot's `defaults` directive *replaces*
wholesale rather than merging (confirmed in dispatcher.py), so a bare
force-only override would silently drop `relink`/`create` too. Added
`install.force.yaml` with the full `{relink, create, force}` triple,
inserted between `install.common.yaml` and the env file only when
`--force` is passed.

**Tested (all read-only or against an isolated fake `$HOME` under
`/tmp`, never the real one):** `--help`, missing `-e`, unknown env,
`-n` passthrough resolving all four envs cleanly, the switch-guard
blocking and `--force` bypassing it (using a manually-seeded
`.installed-env`, not a real install), `install.force.yaml` actually
landing in the composed `-c` args (checked via `bash -x`), and
`clean_repo_symlinks()` against a synthetic `$HOME` with a mix of
repo-symlinks / unrelated-symlinks / real files — only the repo
symlinks were removed. Found and fixed one real bug: `.installed-env`
was being written even on a dry-run.

## 5. `README.md`
- [x] Update "How to run" to `./install -e <env>`
- [x] Document `--force`/`--clean`/`.installed-env`
- [x] Resolve `run/` script naming mismatch — renamed `run/macos` → `run/mac`,
      documented that `run/omarchy` currently serves both omarchy3 and omarchy4

## Rollout / verification order
- [x] 1. Branch + progress tracking (this file, this commit)
- [x] 2. Bump dotbot submodule, confirm multi-`-c` + `--dry-run`
- [x] 3. Land common/per-env yaml split, `--dry-run` no-op check, delete old file
- [x] 4. `git mv` hypr → omarchy3, omarchy → omarchy3, wire up, no-op check
- [x] 5. Seed omarchy4 from live state (hypr, omarchy, ghostty, lazygit), wire into yaml
- [x] 6. Add mac-specific files, wire into `install.mac.yaml`
- [x] 7. Update `install` script + `.gitignore` + README
- [x] 8. Test env-lock guard without touching filesystem
- [ ] 9. First real run on this box (`--force`, backup-and-diff verification) —
      **BLOCKED, stopped and flagged to user**: this step inherently writes
      into `$HOME` (replacing `~/.config/{hypr,omarchy,ghostty,lazygit}`
      with symlinks), which conflicts with the explicit instruction "make
      sure no files outside the repo are modified" for this session. All
      repo-side work is done and verified via `--dry-run`/`bash -x`/isolated
      fake-`$HOME` tests; nothing outside the repo has been touched. Waiting
      on the user to say go before actually running `./install --force -e
      omarchy4` for real.
- [x] 10. Confirm mac-branch diff clean; leave `temporary-mac-config` in place
      (done as part of §3 above)

## 6. Post-review fixes + simplification

§6 was rewritten by the user/reviewer partway through implementation:
beyond fixing defects, it replaced the whole shared-yaml architecture
with self-contained per-env yamls (§6.0). **§6 supersedes §1 and §4
wherever they conflict.** All items below implemented and verified
against an isolated fake `$HOME` (never the real one) or synthetic dirs.

- [x] 6.0 (the simplification, done first) — deleted
      `install.common.yaml`, `install.force.yaml`, and the interim
      `install.defaults.yaml`. Each `install.<env>.yaml` is now fully
      self-contained: its own `defaults:` (with `backup: true`), its
      own `clean:`, its own `link:`. `--force` removed entirely —
      `backup: true` renames a real file/dir aside to
      `<path>.dotbot-backup.<timestamp>` instead of deleting it, fires
      only on the first run (later runs are plain relinks), and is left
      on permanently. Flags collapse to `-e`/`--env` and `--clean` only.
      Renamed the `default/` directory convention to `common/`
      (`ghostty/default/` → `ghostty/common/`, `waybar/default/` →
      `waybar/common/`) per the new naming rule: directories may say
      `common`, no `install.*.yaml` file name may say `common` or
      `default`. `lazygit/config.yml` → `lazygit/common/config.yml`,
      `lazygit.mac/config.yml` → `lazygit/mac/config.yml` (brings
      lazygit under the same app-directory convention as everything
      else). `install` script rewritten: `DOTBOT_CONFIGS` array gone,
      single `-c "${CONFIG}"`; `available_envs()` no longer needs an
      exclusion list (the common/force/defaults files it used to
      exclude don't exist anymore).
- [x] 6.1 — `-e` validated against `available_envs()` (now trivially
      simple, no exclusions needed) rather than file existence. Mostly
      moot after 6.0 removed the pseudo-env files, but kept as a cheap
      explicit check. Verified `-e force`/`-e common` still rejected.
- [x] 6.2 — **dissolved by 6.0.** The original bug (`--force` never
      reaching `install.common.yaml`'s links, because dotbot's
      `defaults:` replaces wholesale and `install.force.yaml` composed
      after common's links had already run) can't happen when there's
      no shared yaml and no `--force`. Nothing to implement.
- [x] 6.3 — ghostty restructured to `ghostty/common/` + `ghostty/omarchy4/`,
      both linked as leaf directories (never the `ghostty/` app dir
      itself), so an env switch is always a symlink-to-symlink relink.
      Verified: repo's `ghostty/common/config` hash identical
      before/after installing omarchy3 then switching to omarchy4 with
      `--clean` (the scenario that used to corrupt it).
- [x] 6.4 — `--clean` warns and skips non-writable scan dirs (e.g.
      `/etc/keyd` without sudo) instead of dying under `set -e`.
      Unchanged by 6.0, still correct.
- [x] 6.5 — `-e` as the final CLI arg errors with usage instead of dying
      silently on a failed `shift 2`. Unchanged by 6.0, still correct.
- [x] 6.6 — dotbot's exit code captured explicitly (`set +e` / `DOTBOT_RC`
      / `set -e`): failure (e.g. keyd without sudo) prints a clear
      message and exits without touching `.installed-env`; success
      chowns `.installed-env` to `$SUDO_USER` when run via sudo, and
      prints a `run/<env>` follow-up. Updated for 6.0's single `-c
      "${CONFIG}"` (no more `DOTBOT_CONFIGS` array).
- [x] 6.7 — `run/omarchy` → `run/omarchy3`, `run/omarchy4` seeded as a
      copy. `run/` maps 1:1 onto `-e` values. README updated (real
      filenames, removed the mismatch paragraph, documented the
      leaf-directory invariant). Unchanged by 6.0.
- [x] 6.8 — folded into 6.0 above (`waybar/common/`, `lazygit/common/`,
      `lazygit/mac/`) rather than done separately, since 6.0 introduced
      the `common/` rename these were going to need anyway.

## Rollout additions (11-16)
- [x] 11. Applied 6.0 first — deleted the shared yaml files, expanded all
      four env yamls to be self-contained with `backup: true`, collapsed
      flags to `-e`/`--clean`. `dotbot -n` on all four envs: clean, no
      "Nonexistent target" warnings, `backup:` correctly shows "Would
      backup" instead of failing on the real live directories.
- [x] 12. Applied 6.3 (ghostty) and the folded-in 6.8 (waybar, lazygit)
      `common/` directory moves together with 6.0, since they're the
      same rename. Re-ran `-n` for all four envs after.
- [x] 13. Applied 6.1, 6.4, 6.5, 6.7 (6.4/6.5/6.7 were already correct
      from the first pass and needed no further change; 6.1 simplified
      as noted above).
- [x] 14. Applied 6.6 last, updated for 6.0's single-`-c` invocation.
- [x] 15. Re-verified the guard end-to-end against an isolated fake
      `$HOME`: seeded `.installed-env`, confirmed a plain switch is
      refused and `--clean -e <env>` gets through; confirmed a full
      real (non-dry-run) success path writes `.installed-env` and
      prints the `Next:` line; confirmed `backup: true` renames a real
      directory aside (not deleted) on first install.
- [ ] 16. Rollout step 9 (first real run on this box) — **still blocked**,
      same as before: requires writing into the real `$HOME`, conflicts
      with this session's "no files outside the repo modified"
      instruction. Waiting on the user's explicit go-ahead. **Now
      materially safer than originally planned** — `backup: true` means
      an unexpected mismatch renames the live config aside instead of
      deleting it, so the manual `cp -r ... .orig` belt-and-braces step
      from the original plan is optional rather than essential.

## Notes / deviations from plan

Summary list — full detail is inline under each section above:

1. ~~Kept `nvim` and `gitconfig` out of `install.common.yaml` (§1)~~ —
   **superseded**: `install.common.yaml` no longer exists (§6.0). The
   underlying decision still holds though — `nvim` and `gitconfig`
   deliberately don't appear in any `install.<env>.yaml`, matching
   today's actual behavior.
2. The plan's example dotbot invocation (repeated `-c file1 -c file2`)
   doesn't work — argparse overwrites rather than appends. Correct form
   is one `-c` with space-separated files. No longer relevant to the
   `install` script itself post-§6.0 (single file, single `-c`), but
   worth remembering if a shared yaml is ever reintroduced.
3. dotbot's dry-run prints "Would remove X" for real (non-symlink)
   targets unconditionally, regardless of `force` — a dry-run-only
   quirk, not a sign the real force-gate is bypassed. See §2. (Post-§6.0
   this manifests as dry-run's "Would backup" line instead — same
   underlying quirk, harmless.)
4. `run/macos` (now `run/mac`) was missing `brew install worktrunk`,
   a real dependency of `zshrc.mac`/`lazygit.mac`. Added. See §3.
5. ~~`--force` needed its own full `defaults:` override file~~ —
   **superseded**: `--force` and `install.force.yaml` were both deleted
   in §6.0, replaced by `backup: true` in each env's own `defaults:`.
6. Found and fixed a bug in my own first draft of `install`: it wrote
   `.installed-env` even on a `-n`/dry-run invocation. See §4/§6.6 —
   this fix carried forward unchanged through the §6.0 rewrite.
7. **Rollout step 9/16 (the first real live run) is intentionally not
   done.** It requires writing into `$HOME`, which conflicts with this
   session's explicit "no files outside the repo modified" instruction.
   Stopped and flagged to the user rather than proceeding. Everything
   up to that point is complete and verified without touching `$HOME`.
8. **Testing limitation, not a bug:** none of the sandboxed/fake-`$HOME`
   test runs in this environment can get a full end-to-end success
   through the real `/etc/keyd` link, since that requires actual root
   and this session never uses real `sudo`. Worked around by using a
   throwaway, uncommitted `install.testonly.yaml` (no keyd link) to
   verify the full-success path (`.installed-env` write, `chown`,
   `Next:` message, `backup:` renaming a real dir aside) — deleted
   immediately after each use, never committed.
