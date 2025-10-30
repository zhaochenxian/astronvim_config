# Font setup: JetBrainsMono Nerd Font Mono

This document shows how to install and configure JetBrainsMono Nerd Font Mono for Neovim and terminal/GUI clients. The repository includes two helper scripts:

- `scripts/install_fonts.sh` — Linux/macOS (bash)
- `scripts/install_fonts.ps1` — Windows PowerShell

## Goals
- Install JetBrainsMono Nerd Font on a fresh machine automatically.
- Configure GUI Neovim clients (neovide, nvim-qt, goneovim) to use the font.
- Provide terminal emulator snippets for setting the font (Alacritty, Windows Terminal, WezTerm, Kitty).

---

## 1) Install fonts (recommended)

Linux/macOS (bash):

```bash
# Make executable
chmod +x scripts/install_fonts.sh
# Run
./scripts/install_fonts.sh
```

macOS uses Homebrew's cask-fonts to install the Nerd Font. On Linux the script downloads the latest JetBrainsMono.zip from Nerd Fonts, extracts `.ttf` files to `~/.local/share/fonts/JetBrainsMonoNerd` and runs `fc-cache -fv`.

Windows (PowerShell):

```powershell
# Run in an elevated PowerShell to install to system fonts (recommended)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\install_fonts.ps1
```

The PowerShell script downloads the zip, extracts it and copies `.ttf` files into the Windows Fonts folder using the Shell COM object (this is the standard approach to "install" fonts programmatically). You may need to log out and log in for apps to detect the new fonts.

---

## 2) Configure Neovim GUI clients

In your `init.lua` (or `lua/user/init.lua`), set `guifont`. Example (Lua):

```lua
-- Set a default guifont for GUI clients (Neovide / nvim-qt / goneovim)
-- Adjust point size (h##) to taste.
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"

-- If you want to apply only for specific GUI (optional):
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
elseif vim.g.goneovim then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
end
```

Notes:
- `guifont` is used by GUI clients (neovide, nvim-qt, goneovim, etc.). Terminal Neovim does not control fonts.
- Use `:set guifont?` in Neovim to see the active font if you're unsure.

---

## 3) Terminal emulator examples (set the font in the terminal config)

Alacritty (`alacritty.yml`):

```yaml
font:
  normal:
    family: "JetBrainsMono Nerd Font Mono"
  size: 14.0
```

Windows Terminal (`settings.json` snippet):

```json
"profiles": {
  "defaults": {
    "fontFace": "JetBrainsMono Nerd Font Mono",
    "fontSize": 12
  }
}
```

WezTerm (`wezterm.lua`):

```lua
return {
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  font_size = 12.0,
}
```

Kitty (`kitty.conf`):

```
font_family JetBrainsMono Nerd Font Mono
font_size 14.0
```

---

## 4) Tips for dotfiles / new machine setup

- Add `./scripts/install_fonts.sh` (or `install_fonts.ps1`) to your machine bootstrap script so fonts are installed automatically.
- After installation, configure terminal/GUI settings (some tools read their config only on start). Consider setting dotfiles to update Windows Terminal settings or Alacritty config programmatically.
- If you manage machines with a provisioner (Ansible / dotfiles manager), add the install script as a task.

---

## 5) Troubleshooting

- If the GUI client doesn't show the font immediately, restart the GUI and/or the system.
- On Linux, ensure `fontconfig` is installed and `fc-cache` is available.
- On Windows, if fonts don't appear, log out/in or reboot; ensure you ran PowerShell with elevated privileges if installing system-wide.


