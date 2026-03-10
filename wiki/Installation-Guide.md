# Installation Guide

## Prerequisites

You need:
- A Mac or Windows computer
- Internet connection
- A GitHub account (ask your admin if you don't have one)
- Access to the SureCart GitHub organization (ask your admin)

Everything else is installed automatically by the setup script.

## Mac Setup (Step by Step)

### Step 1: Open Terminal
- Press `Cmd + Space` to open Spotlight
- Type "Terminal" and press Enter
- A black/white window will appear — this is your terminal

### Step 2: Download the Support Tool
Copy and paste this line into the terminal, then press Enter:
```
git clone https://github.com/surecart/surecart-support.git ~/surecart-support
```

### Step 3: Run the Setup
Copy and paste this line, then press Enter:
```
cd ~/surecart-support && chmod +x setup-mac.sh && ./setup-mac.sh
```

The script will:
- Install developer tools (you may see a popup — click "Install")
- Install Homebrew (a package manager)
- Install Node.js and GitHub CLI
- Install Claude Code CLI
- Ask you to sign into GitHub (a browser window will open)
- Download all SureCart code repositories

This takes about 5-10 minutes the first time.

### Step 4: Restart Terminal
- Close the terminal window completely (Cmd + Q)
- Open Terminal again (Spotlight → "Terminal")

### Step 5: Launch
Type `sc-support` and press Enter. You're ready!

The first time, you'll be asked to sign into your Claude team account.
Then type `/mcp` and press Enter to connect the documentation server.

## Windows Setup (Step by Step)

### Step 1: Open PowerShell
- Click the Start button
- Type "PowerShell" and click "Windows PowerShell"

### Step 2: Download the Support Tool
Paste this and press Enter:
```
git clone https://github.com/surecart/surecart-support.git $HOME\surecart-support
```

If you see "git is not recognized", you need Git installed first:
- Open Microsoft Store → search "Git" → install "Git for Windows"
- Close and reopen PowerShell, then try again

### Step 3: Run the Setup
Paste this and press Enter:
```
cd $HOME\surecart-support; .\setup-windows.ps1
```

If you see an "execution policy" error:
- Run: `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`
- Type "Y" when asked
- Then try the setup command again

### Step 4: Launch
- Look for "SureCart Support" icon on your Desktop
- Double-click it to start

## After Setup

Your daily workflow is just:
1. Type `sc-support` (Mac) or double-click the desktop icon (Windows)
2. Ask your question
3. That's it! Updates happen automatically.
