# My Dotfiles

Intended to be used for local development and (at one point) Github Codespaces.

Installation managed by <a href="https://github.com/anishathalye/dotbot">dotbot</a>.

## How to run

```bash
./install
```

Note that some symlinks may need to be run using `sudo` (i.e. the ones created in `/etc`).

## After install

Then run any of the shell scripts under `/run` as necessary. Example:

```bash
sh ./run/fedora
sh ./run/global # NOTE: This should come after specific environment scripts
sh ./run/vim
```
