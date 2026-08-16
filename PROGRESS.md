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

## 4. `install` script: `-e/--env`, `--force`, `--clean`, env lock
- [ ] Arg parsing (`-e/--env`, `--force`, `--clean`, `-h/--help`)
- [ ] Usage/error when `-e` missing or unknown env
- [ ] `.installed-env` write-after-success + read-and-compare guard
- [ ] `.gitignore` added (`.installed-env`, `.DS_Store`, `*.bak.*`)
- [ ] `--clean` symlink-scan implementation
- [ ] Guard message text matches plan

## 5. `README.md`
- [ ] Update "How to run" to `./install -e <env>`
- [ ] Document `--force`/`--clean`/`.installed-env`
- [ ] Resolve `run/` script naming mismatch (rename vs. thin wrappers) and document

## Rollout / verification order
- [x] 1. Branch + progress tracking (this file, this commit)
- [ ] 2. Bump dotbot submodule, confirm multi-`-c` + `--dry-run`
- [ ] 3. Land common/per-env yaml split, `--dry-run` no-op check, delete old file
- [ ] 4. `git mv` hypr → omarchy3, omarchy → omarchy3, wire up, no-op check
- [ ] 5. Seed omarchy4 from live state (hypr, omarchy, ghostty, lazygit), wire into yaml
- [ ] 6. Add mac-specific files, wire into `install.mac.yaml`
- [ ] 7. Update `install` script + `.gitignore` + README
- [ ] 8. Test env-lock guard without touching filesystem
- [ ] 9. First real run on this box (`--force`, backup-and-diff verification)
- [ ] 10. Confirm mac-branch diff clean; leave `temporary-mac-config` in place

## Notes / deviations from plan
(none yet)
