# My Dotfiles

Intended to be used for local development and (at one point) Github Codespaces.

Installation managed by <a href="https://github.com/anishathalye/dotbot">dotbot</a>.

## How to run

```bash
./install -e <omarchy3|omarchy4|mac|fedora>
```

`-e`/`--env` is required — each `install.<env>.yaml` is fully
self-contained (no shared config file to compose it with). There's no
default, on purpose: better to fail loudly than silently link the wrong
environment's config.

Every link is set up with dotbot's `backup: true`, so a real file or
directory standing where a symlink should go gets renamed aside to
`<path>.dotbot-backup.<timestamp>` instead of touched destructively.
That only fires the first time (later runs just relink), so it's safe to
leave on permanently — there's no separate "force" flag.

Note that some symlinks may need to be run using `sudo` (i.e. the ones created in `/etc`),
in which case do this instead:

```
sudo ./install -e <env>
```

### Switching environments on the same machine

The last environment successfully installed is recorded in
`.installed-env`. Running `./install -e <env>` for a *different*
environment than what's recorded is blocked by default, with an
explanation — dotbot's `clean` only removes *broken* symlinks, so a still
-valid symlink from a previous environment (e.g. `~/.config/hypr` pointing
at `hypr/omarchy3`) would otherwise be silently left in place instead of
replaced. If you actually want to switch, do what the error message says:

```bash
./install --clean -e <new-env>
```

`--clean` removes this repo's own symlinks first, so nothing from the old
environment is left behind even if the new environment doesn't declare
that path at all — this is also what's required to get past the
switch-guard, since it's exactly what resolves the problem the guard is
warning about.

Any other flags (e.g. `-n`/`--dry-run`, `-v`) are passed straight through
to dotbot.

## After install

Then run any of the shell scripts under `/run` as necessary. `run/global`
should come after the environment-specific script:

```bash
sh ./run/omarchy4   # or ./run/omarchy3, ./run/mac, ./run/fedora
sh ./run/global
sh ./run/vim
```

`run/` maps 1:1 onto the `-e` values (`omarchy3`, `omarchy4`, `mac`,
`fedora`), with `global` and `vim` as the two deliberate non-env extras.
`run/omarchy3` and `run/omarchy4` currently start out identical — split
them apart as real per-version package differences show up.

## Directory conventions

- **App directories** (`hypr/`, `omarchy/`, `ghostty/`, `waybar/`,
  `lazygit/`) use `<app>/<env>/` and `<app>/common/`, where `common`
  means "shared by more than one environment" — e.g. `hypr/omarchy3/`,
  `hypr/omarchy4/`, `ghostty/common/`. Nothing is a fallback or an
  override: every env yaml names its source directory explicitly.
- **An env yaml may only link a leaf directory under an app directory —
  never the app directory itself** (e.g. `~/.config/ghostty` →
  `ghostty/omarchy4`, never → `ghostty`). This is what makes switching
  environments a plain symlink-to-symlink relink instead of ever writing
  through a stale symlink into the repo.
- **Bare top-level dotfiles** with no app directory (`zshrc`, `tmux.conf`)
  use a flat `<name>.<env>` sibling instead (e.g. `zshrc.mac`), since
  there's no app directory to nest under.
- No yaml file uses the words `common` or `default` in its own name —
  those words describe directories, not `install.*.yaml` files. Every
  `install.<env>.yaml` is self-contained.

## Themes

https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme?tab=readme-ov-file
