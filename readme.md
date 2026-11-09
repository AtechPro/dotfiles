# Dotfiles Restow Guide (GNU Stow)

This guide explains how to restow dotfiles using **GNU Stow**. These dotfiles include configurations for Fish shell, Hyprland window manager, Kitty terminal, Starship prompt, and various notes.

---

# 1. Install GNU Stow

### Arch / Manjaro / Ormachry 

```bash
sudo pacman -S stow
```

### Debian / Ubuntu

```bash
sudo apt update && sudo apt install stow
```

### Fedora

```bash
sudo dnf install stow
```

### OpenSUSE

```bash
sudo zypper install stow
```

### Verify installation

```bash
stow --version
```

---


# Understand Structure

Stow works by mirroring folder structure into `$HOME`.

Example:

```
dotfiles/
 ├── fish/.config/fish/
 ├── hyprland/.config/hypr/
 ├── kitty/.config/kitty/
 ├── starship/.config/
 ├── notes/
```

Each folder = one module.

---

# Available Modules

- **fish**: Fish shell configuration files (config.fish, auto-Hypr.fish, fish_variables, functions/zseed.fish)
- **hyprland**: Hyprland window manager configs (hyprland.conf, monitors.conf, workspaces.conf)
- **kitty**: Kitty terminal emulator settings (kitty.conf, scroll_mark.py, search.py)
- **starship**: Starship prompt configuration (starship.toml)
- **notes**: Miscellaneous notes and guides (e.g., grubrecovery.md)

---

# Restow Dotfiles

Run stow per module:

```bash
stow fish
stow hyprland
stow kitty
stow starship
```

For notes (if you want them in ~/notes):

```bash
stow notes
```

This creates symlinks into `~/.config/` and `~/notes/`.

---

# Safe Preview

Check before applying:

```bash
stow -n -v fish
stow -n -v hyprland
stow -n -v kitty
stow -n -v starship
stow -n -v notes
```

---

# Shell Tooling (installed alongside Stow)

## zoxide — smarter `cd`

Directory jumper that learns which directories you actually use and ranks them by
frecency (frequency + recency). It is a separate package, not part of this repo:

```bash
# Arch
sudo pacman -S zoxide fzf

# Debian / Ubuntu
sudo apt install zoxide fzf
```

`fzf` is only needed for the interactive `zi` picker — `z` works without it.

Wiring lives in `fish/.config/fish/config.fish`, inside the interactive guard so
non-interactive `fish -c` calls don't pay for it:

```fish
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting ""
    starship init fish | source
    zoxide init fish | source
end
```

Reload with `exec fish` after pulling.

### Usage

| Command | Effect |
| --- | --- |
| `z forge` | jump to the best frecency match for `forge` |
| `z tv launchers` | multiple keywords, matched in any order |
| `zi` | interactive fzf picker over tracked directories |
| `zoxide query -ls` | list the whole database with scores |
| `zoxide remove <dir>` | forget a directory |
| `zoxide edit` | open the raw list in `$EDITOR` |

Matching is case-insensitive on any part of the path, so `z dot` finds
`~/dotfiles` without typing the full name.

### Seeding project directories — `zseed`

`fish/.config/fish/functions/zseed.fish` (autoloaded from
`~/.config/fish/functions/`, symlinked by `stow fish`) primes the database so the
first `z` isn't a guessing game:

- adds a curated list of project roots (`~/dotfiles`, `~/stable-diffusion-webui-forge`,
  `~/tv-launchers/*`, `~/mtkclient`, …)
- auto-discovers any git repo sitting directly under `$HOME`
- dedupes and reports a count

```bash
zseed
# zseed: 14 project dirs added, 14 tracked in zoxide
```

Re-run it after creating or cloning a project; ordinary `cd`s are tracked
automatically, so the seed is only a starting boost.

### Optional knobs

Add to `config.fish` if wanted:

```fish
set -gx _ZO_ECHO 1                            # print the directory after jumping
set -gx _ZO_EXCLUDE_DIRS "$HOME:/tmp/*"       # colon-separated globs on Unix
```

### State

| Path | Contents |
| --- | --- |
| `~/.local/share/zoxide/db.zo` | the frecency database |
| `~/.config/zoxide/` | optional config (not used here) |

Deleting `db.zo` resets history; nothing else breaks because the directories
themselves are untouched.

---

# Troubleshooting

If conflicts occur, remove existing configs first:

```bash
rm -rf ~/.config/fish
stow fish
```

For more help: `stow --help`

# 8. Common Problems

### File conflicts

If config already exists:

```bash
stow -D hyprland
rm -rf ~/.config/hypr
stow hyprland
```

---

### Wrong folder structure

Bad:

```
hyprland/hypr/hyprland.conf
```

Good:

```
hyprland/.config/hypr/hyprland.conf
```

---

# 9. Recommended Workflow

* Keep dotfiles in Git repository
* Use Stow per application/module
* Always test with `-n` before applying
* Commit changes regularly

---

# 10. Minimal Recovery Command

```bash
cd ~/dotfiles
stow hyprland kitty
hyprctl reload
```

---

# Notes

* Works on any Linux distribution (as long as stow is installed)
* Hyprland-specific commands (like `hyprctl`) require Hyprland session only
* Stow itself is distro-independent
* [GRUB Recovery Guide](notes/grubrecovery.md)
* [Guide of How to install Noctalia](https://docs.noctalia.dev/v4/)
---

