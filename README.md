# Dotfiles

Minimal dotfiles for Ghostty and SSH with local/private SSH config handling and generated Tailscale host entries.

## Quick Setup (60 seconds)

```bash
git clone <your-dotfiles-repo-url> ~/development/dotfiles
cd ~/development/dotfiles
./scripts/bootstrap
make doctor
```

If `tailscale status --json` is already healthy, bootstrap will also generate `~/.ssh/config.tailscale`.

## Common Commands

```bash
make help           # list available commands
make bootstrap      # install/check deps + link configs
make install        # only link configs
make tailscale-ssh  # regenerate ~/.ssh/config.tailscale
make doctor         # validate setup
make update         # refresh generated SSH config + run doctor
```

## SSH Layout

- `ssh/config.example` (tracked): template for your local SSH config.
- `ssh/config` (ignored): your machine-local SSH config linked to `~/.ssh/config`.
- `~/.ssh/config.local` (not in repo): machine-specific private entries.
- `~/.ssh/config.tailscale` (not in repo): generated from `tailscale status --json`.

The installer copies `ssh/config.example` to `ssh/config` on first run if needed.

## Privacy Model

Public repo contains reusable scripts and templates.
Private hostnames, aliases, and peer inventory live in generated/local files only.

## Requirements

- `bash`
- `ssh`
- `jq`
- `tailscale`

`scripts/bootstrap` installs missing requirements via Homebrew when available.
