# SureCart Support Assistant

AI-powered assistant for answering customer questions about SureCart.

**Full documentation:** [Wiki](../../wiki)

## Quick Start

### Mac
1. Open Terminal (Spotlight → type "Terminal" → press Enter)
2. Paste: `git clone https://github.com/surecart/surecart-support.git ~/surecart-support`
3. Run: `cd ~/surecart-support && chmod +x setup-mac.sh && ./setup-mac.sh`
4. Follow the prompts → close Terminal → open new Terminal → type: `sc-support`

### Windows
1. Open PowerShell (Start → type "PowerShell")
2. Paste: `git clone https://github.com/surecart/surecart-support.git $HOME\surecart-support`
3. Run: `cd $HOME\surecart-support; .\setup-windows.ps1`
4. Follow the prompts → double-click "SureCart Support" on your Desktop

See [Installation Guide](../../wiki/Installation-Guide) for detailed step-by-step instructions with screenshots.

## What It Does

- Answers customer questions by searching SureCart's codebase and documentation
- Guided troubleshooting with `/troubleshoot`
- API endpoint lookup with `/lookup-api`
- Documentation search with `/search-docs`
- Code flow tracing with `/trace-flow`
- Read-only — cannot modify any files or data
- Auto-updates every time you launch
