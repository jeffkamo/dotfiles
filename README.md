# My Dotfiles

Intended to be used for local development and (at one point) Github Codespaces.

Installation managed by <a href="https://github.com/anishathalye/dotbot">dotbot</a>.

## How to run

```bash
./install -e <omarchy3|omarchy4|mac|fedora>
```

`-e`/`--env` is required — it selects which `install.<env>.yaml` gets
composed with the shared `install.common.yaml`. There's no default, on
purpose: better to fail loudly than silently link the wrong environment's
config.

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
./install --force --clean -e <new-env>
```

- `--force` bypasses the switch guard and lets dotbot replace existing
  real files/directories (not just broken symlinks) with new ones.
- `--clean` removes this repo's own symlinks first, so nothing from the
  old environment is left behind even if the new environment doesn't
  declare that path at all.

Any other flags (e.g. `-n`/`--dry-run`, `-v`) are passed straight through
to dotbot.

## After install

Then run any of the shell scripts under `/run` as necessary. `run/global`
should come after the environment-specific script:

```bash
sh ./run/omarchy3   # or omarchy4, mac, fedora — see below
sh ./run/global
sh ./run/vim
```

Note the `run/` scripts aren't a strict 1:1 mapping with the install
environments:

- `run/omarchy` covers package setup shared by both `omarchy3` and
  `omarchy4` — there isn't a per-version split yet.
- `run/mac` corresponds to the `mac` environment.
- `run/fedora` corresponds to the `fedora` environment.
- `run/global` and `run/vim` are environment-independent.

## Themes

https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme?tab=readme-ov-file
