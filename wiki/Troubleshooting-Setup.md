# Troubleshooting Setup

## Mac Issues

### "command not found: git"
**Cause:** Xcode Command Line Tools not installed
**Fix:** Run `xcode-select --install` and follow the popup. Then re-run `./setup-mac.sh`

### "command not found: brew"
**Cause:** Homebrew not installed or not in PATH
**Fix:**
1. Run: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. If on Apple Silicon Mac (M1/M2/M3), also run: `eval "$(/opt/homebrew/bin/brew shellenv)"`
3. Re-run `./setup-mac.sh`

### "command not found: sc-support" after setup
**Cause:** Shell alias not loaded
**Fix:** Close Terminal completely (Cmd+Q) and open a new one. The alias loads on startup.

### "Permission denied" when running setup-mac.sh
**Cause:** Script not marked as executable
**Fix:** Run: `chmod +x setup-mac.sh && ./setup-mac.sh`

### "Could not clone repository. Access denied."
**Cause:** You don't have access to the SureCart GitHub repos
**Fix:** Ask your admin to add you with "Read" access to the repos

### Setup script hangs at "Installing developer tools"
**Cause:** Xcode CLT popup appeared behind other windows
**Fix:** Look for the "Install Command Line Tools" popup. Click "Install" and wait.

## Windows Issues

### "git is not recognized"
**Cause:** Git not installed
**Fix:** Open Microsoft Store → search "Git for Windows" → install. Reopen PowerShell.

### "execution policy" error
**Cause:** PowerShell blocks scripts by default
**Fix:** Run: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` → type Y

### "winget is not recognized"
**Cause:** Windows Package Manager not installed
**Fix:** Open Microsoft Store → search "App Installer" → install or update

### Desktop shortcut doesn't work
**Cause:** Path issues after moving the folder
**Fix:** Re-run `.\setup-windows.ps1` to regenerate the shortcut

## Both Platforms

### "Claude Code not found" or authentication error
**Fix:**
1. Run: `npm install -g @anthropic-ai/claude-code`
2. Run: `claude` and sign in with your team email

### MCP server not connecting
**Fix:** Type `/mcp` inside the assistant and follow the authentication prompts

### Assistant is slow to start
**Normal!** First launch downloads updates. Subsequent launches are faster (~3 seconds).

### "I made a mistake during setup"
**Fix:** Just re-run the setup script. It's safe to run multiple times — it skips already-installed steps.
