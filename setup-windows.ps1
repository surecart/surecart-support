# SureCart Support Assistant — Windows Setup
# Run as: Right-click → "Run with PowerShell"
# Or from PowerShell: .\setup-windows.ps1

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ReposDir = Join-Path $ScriptDir ".repos"

function Print-Error {
    param([string]$Title, [string]$HowToFix)
    Write-Host ""
    Write-Host "======================================" -ForegroundColor Red
    Write-Host "  ERROR: $Title" -ForegroundColor Red
    Write-Host "======================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "What to do:" -ForegroundColor Yellow
    Write-Host $HowToFix
    Write-Host ""
    Write-Host "If you're still stuck, take a screenshot of this window and send it to your admin." -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Press Enter to close"
    exit 1
}

Write-Host "======================================"
Write-Host "  SureCart Support Assistant Setup"
Write-Host "======================================"
Write-Host ""
Write-Host "This will install everything you need. Just follow the prompts!"
Write-Host ""

# ── Step 1: winget ──
Write-Host "Step 1/5: Checking package manager..."
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Print-Error "Windows Package Manager (winget) not found" @"
  winget comes pre-installed on Windows 11 and most Windows 10 PCs.

  To install it:
  1. Open the Microsoft Store app
  2. Search for 'App Installer'
  3. Click 'Get' or 'Update'
  4. Once installed, close this window and run setup-windows.ps1 again

  If you can't find it, ask your admin for help.
"@
}
Write-Host "Step 1/5: Package manager ✓" -ForegroundColor Green

# ── Step 2: Git ──
Write-Host "Step 2/5: Checking Git..."
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing Git (this may take a minute)..."
    winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Print-Error "Git installation failed" @"
  Try these steps:
  1. Open Microsoft Store and make sure 'App Installer' is updated
  2. Run this script again
  3. If it still fails, ask your admin to install Git manually from:
     https://git-scm.com/download/win
"@
    }
    # Refresh PATH
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
}
Write-Host "Step 2/5: Git ✓" -ForegroundColor Green

# ── Step 3: Node.js + GitHub CLI ──
Write-Host "Step 3/5: Checking Node.js and GitHub CLI..."
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing Node.js..."
    winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Print-Error "Node.js installation failed" @"
  Try these steps:
  1. Run this script again
  2. If it still fails, download Node.js manually from:
     https://nodejs.org (click the LTS/Recommended button)
  3. Run the installer, then run this script again
"@
    }
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
}

if (!(Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing GitHub CLI..."
    winget install --id GitHub.cli -e --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Print-Error "GitHub CLI installation failed" @"
  Try these steps:
  1. Run this script again
  2. If it still fails, download GitHub CLI from:
     https://cli.github.com
  3. Run the installer, then run this script again
"@
    }
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
}
Write-Host "Step 3/5: Node.js + GitHub CLI ✓" -ForegroundColor Green

# ── Step 4: Claude Code CLI ──
Write-Host "Step 4/5: Checking Claude Code..."
if (!(Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
    if ($LASTEXITCODE -ne 0) {
        Print-Error "Claude Code CLI installation failed" @"
  Try these steps:
  1. Close this window and open a new PowerShell
  2. Run: npm install -g @anthropic-ai/claude-code
  3. If that fails, ask your admin for help
"@
    }
}
Write-Host "Step 4/5: Claude Code CLI ✓" -ForegroundColor Green

# ── Step 5: GitHub login + clone repos ──
Write-Host "Step 5/5: Setting up repositories..."
Write-Host ""

$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  You need to sign into GitHub. Here's what will happen:" -ForegroundColor Yellow
    Write-Host "  -> A browser window will open"
    Write-Host "  -> Sign in with your GitHub account"
    Write-Host "  -> Click 'Authorize' when asked"
    Write-Host "  -> Come back to this window when done"
    Write-Host ""
    Read-Host "  Press Enter to open the browser"
    gh auth login --web --git-protocol https
    if ($LASTEXITCODE -ne 0) {
        Print-Error "GitHub login failed" @"
  1. Make sure you have a GitHub account
     (ask your admin if you don't have one)
  2. Make sure you're connected to the internet
  3. Try running this script again
"@
    }
}

New-Item -ItemType Directory -Force -Path $ReposDir | Out-Null

$repos = @("surecart-wp", "surecart", "surecart-docs", "surecart-support.wiki", "wordpress-sdk")
foreach ($repo in $repos) {
    $repoDir = Join-Path $ReposDir $repo
    if (!(Test-Path $repoDir)) {
        Write-Host "  Downloading $repo..."
        git clone --depth 1 "https://github.com/surecart/$repo.git" $repoDir
        if ($LASTEXITCODE -ne 0) {
            Print-Error "Could not download '$repo' repository" @"
  This usually means you don't have access. Here's how to fix it:

  1. Go to github.com and make sure you're logged in
  2. Ask your admin (Raj) to give you Read access to:
     -> github.com/surecart/$repo

  Your admin needs to:
  -> Go to github.com/surecart/$repo/settings/access
  -> Click 'Add people' -> search for your GitHub username
  -> Set role to 'Read'

  Once you have access, run this script again.
"@
        }
    }
}
Write-Host "Step 5/5: Repositories ✓" -ForegroundColor Green

# ── Create launch-windows.bat ──
$batchContent = @"
@echo off
echo Updating SureCart Support...
cd /d "$ScriptDir"
git pull --ff-only 2>nul
for %%r in (surecart-wp surecart surecart-docs surecart-support.wiki wordpress-sdk) do (
    cd /d "$ReposDir\%%r" 2>nul && git pull --ff-only 2>nul
)
cd /d "$ScriptDir"
echo Ready!
echo.
claude --add-dir "$ReposDir\surecart-wp" --add-dir "$ReposDir\surecart" --add-dir "$ReposDir\surecart-docs" --add-dir "$ReposDir\surecart-support.wiki" --add-dir "$ReposDir\wordpress-sdk"
"@
$batchPath = Join-Path $ScriptDir "launch-windows.bat"
Set-Content -Path $batchPath -Value $batchContent

# ── Create desktop shortcut ──
$desktopPath = [System.Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktopPath "SureCart Support.lnk"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "cmd.exe"
$shortcut.Arguments = "/k `"$ScriptDir\launch-windows.bat`""
$shortcut.WorkingDirectory = $ScriptDir
$shortcut.Save()

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "  WHAT TO DO NOW:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. Look for 'SureCart Support' icon on your Desktop"
Write-Host "  2. Double-click it to start"
Write-Host "  3. The first time, you'll sign into your Claude team account"
Write-Host "  4. Then type /mcp and press Enter to connect the docs"
Write-Host ""
Write-Host "  After that, just double-click the desktop icon anytime!"
Write-Host ""
Write-Host "  Try asking:"
Write-Host '  "Customer checkout is stuck on finalizing — what could cause this?"'
Write-Host ""
Read-Host "Press Enter to close this window"
