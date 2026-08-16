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
- [ ] Write `install.common.yaml`
- [ ] Write `install.omarchy3.yaml`
- [ ] Write `install.omarchy4.yaml`
- [ ] Write `install.fedora.yaml`
- [ ] Write `install.mac.yaml`
- [ ] Verify via `--dry-run` diff against old `install.conf.yaml` (omarchy3 path)
- [ ] Delete superseded `install.conf.yaml`

## 2. Move directory-based configs under nested per-env dirs
- [ ] hypr: `git mv` top-level `hypr/*.conf` → `hypr/omarchy3/` (explicit files, not glob)
- [ ] hypr: drop committed `.bak.*` junk during the move
- [ ] hypr: seed `hypr/omarchy4/` from live `~/.config/hypr`
- [ ] omarchy: `git mv` `omarchy/{branding,current,hooks,themes}` → `omarchy/omarchy3/`
- [ ] omarchy: seed `omarchy/omarchy4/` from live `~/.config/omarchy`
- [ ] ghostty: seed `ghostty/omarchy4/config` from live `~/.config/ghostty/config`
- [ ] lazygit: create empty `lazygit/config.yml` baseline (matches live empty state)
- [ ] waybar: left as-is (no fork needed yet) — confirm still true

## 3. Port mac-specific files as flat `<name>.<env>` siblings
- [ ] `zshrc.mac` from `temporary-mac-config`
- [ ] `tmux.mac.conf` from `temporary-mac-config`
- [ ] `lazygit.mac/config.yml` from `temporary-mac-config`, wired to macOS Application Support path
- [ ] Skip `.bash_profile` (confirmed redundant)
- [ ] Final full-file diff of `temporary-mac-config` vs `main` to confirm nothing else missed
- [ ] Leave `temporary-mac-config` branch in place (do not delete)

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
