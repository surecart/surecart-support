#!/bin/bash

# Exit on error, but we handle errors ourselves with friendly messages
set -e
trap 'echo ""; echo "Something went wrong. Please screenshot this terminal and send it to your admin."; echo ""' ERR

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPOS_DIR="$SCRIPT_DIR/.repos"

print_error() {
    echo ""
    echo "======================================"
    echo "  ❌ ERROR: $1"
    echo "======================================"
    echo ""
    echo "What to do:"
    echo "$2"
    echo ""
    echo "If you're still stuck, screenshot this terminal and send it to your admin."
    echo ""
    exit 1
}

echo "======================================"
echo "  SureCart Support Assistant Setup"
echo "======================================"
echo ""
echo "This will install everything you need. Just follow the prompts!"
echo ""

# ── Step 1: Xcode Command Line Tools (needed for git) ──
echo "Step 1/5: Checking developer tools..."
if ! xcode-select -p &> /dev/null; then
    echo ""
    echo "  A system popup will appear asking to install developer tools."
    echo "  → Click 'Install' in the popup"
    echo "  → Wait for it to finish (may take 5-10 minutes)"
    echo ""
    xcode-select --install 2>/dev/null || true
    echo ""
    echo "======================================"
    echo "  ⏸️  PAUSED — Waiting for install"
    echo "======================================"
    echo ""
    echo "  Once the popup says 'Done' or 'The software was installed':"
    echo "  → Come back to this terminal"
    echo "  → Run this command again:"
    echo ""
    echo "     ./setup-mac.sh"
    echo ""
    exit 0
fi
echo "Step 1/5: Developer tools ✓"

# ── Step 2: Homebrew ──
echo "Step 2/5: Checking package manager..."
if ! command -v brew &> /dev/null; then
    echo "  Installing Homebrew (this may take 2-3 minutes)..."
    echo "  You may be asked for your Mac password — this is normal."
    echo ""
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        print_error "Homebrew installation failed" \
"  1. Check your internet connection
  2. Try running this script again
  3. If it keeps failing, ask your admin to install Homebrew on your Mac"
    fi
    # Add brew to PATH for this session (Apple Silicon Macs)
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi
echo "Step 2/5: Homebrew ✓"

# ── Step 3: Node.js + GitHub CLI ──
echo "Step 3/5: Checking Node.js and GitHub CLI..."
if ! command -v node &> /dev/null; then
    echo "  Installing Node.js..."
    if ! brew install node 2>&1; then
        print_error "Node.js installation failed" \
"  1. Try running: brew update && brew install node
  2. If that fails, ask your admin to install Node.js on your Mac"
    fi
fi

if ! command -v gh &> /dev/null; then
    echo "  Installing GitHub CLI..."
    if ! brew install gh 2>&1; then
        print_error "GitHub CLI installation failed" \
"  1. Try running: brew update && brew install gh
  2. If that fails, ask your admin to install GitHub CLI on your Mac"
    fi
fi
echo "Step 3/5: Node.js + GitHub CLI ✓"

# ── Step 4: Claude Code CLI ──
echo "Step 4/5: Checking Claude Code..."
if ! command -v claude &> /dev/null; then
    echo "  Installing Claude Code CLI..."
    if ! npm install -g @anthropic-ai/claude-code 2>&1; then
        echo "  Trying with sudo..."
        if ! sudo npm install -g @anthropic-ai/claude-code 2>&1; then
            print_error "Claude Code CLI installation failed" \
"  1. Try running: sudo npm install -g @anthropic-ai/claude-code
  2. If asked for a password, enter your Mac password (you won't see it typing)
  3. If that fails, ask your admin to install Claude Code CLI"
        fi
    fi
fi
echo "Step 4/5: Claude Code CLI ✓"

# ── Step 5: GitHub login + clone repos ──
echo "Step 5/5: Setting up repositories..."

if ! gh auth status &> /dev/null 2>&1; then
    echo ""
    echo "  You need to sign into GitHub. Here's what will happen:"
    echo "  → A browser window will open"
    echo "  → Sign in with your GitHub account"
    echo "  → Click 'Authorize' when asked"
    echo "  → Come back to this terminal when done"
    echo ""
    echo "  Press Enter to open the browser..."
    read
    if ! gh auth login --web --git-protocol https; then
        print_error "GitHub login failed" \
"  1. Make sure you have a GitHub account (ask your admin if not)
  2. Make sure you're connected to the internet
  3. Try running this script again
  4. If the browser didn't open, try running: gh auth login"
    fi
fi

mkdir -p "$REPOS_DIR"

clone_repo() {
    local name="$1"
    local dir="$REPOS_DIR/$name"
    if [ ! -d "$dir" ]; then
        echo "  Downloading $name..."
        if ! git clone --depth 1 "https://github.com/surecart/$name.git" "$dir" 2>&1; then
            print_error "Could not download '$name' repository" \
"  This usually means you don't have access. Here's how to fix it:

  1. Go to github.com and make sure you're logged in
  2. Ask your admin (Raj) to give you Read access to:
     → github.com/surecart/$name
  3. Once you have access, run this script again:
     ./setup-mac.sh

  Your admin needs to:
  → Go to github.com/surecart/$name/settings/access
  → Click 'Add people' → search for your GitHub username
  → Set role to 'Read'"
        fi
    fi
}
clone_repo "surecart-wp"
clone_repo "surecart"
clone_repo "surecart-docs"
clone_repo "surecart-support.wiki"
clone_repo "wordpress-sdk"

echo "Step 5/5: Repositories ✓"

# ── Make launch script executable + add shell alias ──
chmod +x "$SCRIPT_DIR/launch-mac.sh"
SHELL_RC="$HOME/.zshrc"
[ ! -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.bashrc"
touch "$SHELL_RC"

ALIAS_LINE="alias sc-support='\"$SCRIPT_DIR/launch-mac.sh\"'"

if ! grep -q "sc-support" "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo "# SureCart Support Assistant" >> "$SHELL_RC"
    echo "$ALIAS_LINE" >> "$SHELL_RC"
fi

echo ""
echo "======================================"
echo "  ✅ Setup Complete!"
echo "======================================"
echo ""
echo "  WHAT TO DO NOW:"
echo ""
echo "  1. Close this terminal window (Cmd+Q)"
echo "  2. Open Terminal again (Spotlight → type 'Terminal' → press Enter)"
echo "  3. Type this command and press Enter:"
echo ""
echo "     sc-support"
echo ""
echo "  4. The first time, you'll sign into your Claude team account"
echo "  5. Then type /mcp and press Enter to connect the docs"
echo ""
echo "  After that, just type 'sc-support' anytime to start!"
echo ""
echo "  Try asking:"
echo '  "Customer checkout is stuck on finalizing — what could cause this?"'
echo ""
