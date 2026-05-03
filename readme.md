# Hyprland Dotfiles Restore Guide (GNU Stow)

This guide explains how to restore Hyprland dotfiles using **GNU Stow** across multiple Linux distributions (Arch, Fedora, Ubuntu, etc.).

---

# 1. Install GNU Stow

### Arch / Manjaro

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
 ├── hyprland/.config/hypr/
 ├── waybar/.config/waybar/
 ├── kitty/.config/kitty/
 ├── nvim/.config/nvim/
```

Each folder = one module.

---

# 4. Restore Dotfiles

Run stow per module:

```bash
stow hyprland
stow waybar
stow kitty
stow nvim
```

This creates symlinks into:

```
~/.config/
```

---

# 5. Safe Preview (Recommended)

Check before applying:

```bash
stow -n -v hyprland
```

---

# 6. Undo Changes

Remove symlinks:

```bash
stow -D hyprland
```

---

# 7. Apply Changes to Hyprland

Reload compositor:

```bash
hyprctl reload
```

Or logout/login session.

---

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
---

Done.
