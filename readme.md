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

# 2. Get Your Dotfiles

If stored in Git:

```bash
git clone https://github.com/yourname/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

If local backup exists:

```bash
cd /path/to/dotfiles
```

---

# 3. Understand Structure

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

- **fish**: Fish shell configuration files (config.fish, auto-Hypr.fish, fish_variables)
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
cd ~/.dotfiles
stow hyprland waybar kitty
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

