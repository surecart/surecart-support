#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPOS_DIR="$SCRIPT_DIR/.repos"
REPOS="surecart-wp surecart surecart-docs surecart-support.wiki wordpress-sdk"

echo "======================================"
echo "  SureCart Support Assistant"
echo "======================================"
echo ""

# Update the support repo itself (picks up new CLAUDE.md, skills, guides)
echo "Updating support assistant..."
(cd "$SCRIPT_DIR" && git pull --ff-only 2>/dev/null)

# Ensure repos directory exists
mkdir -p "$REPOS_DIR"

# Clone missing repos, update existing ones — all in parallel
for repo in $REPOS; do
    dir="$REPOS_DIR/$repo"
    if [ ! -d "$dir/.git" ]; then
        echo "  Cloning $repo (first time)..."
        git clone --depth 1 "https://github.com/surecart/$repo.git" "$dir" 2>&1 | tail -1 &
    else
        echo "  Updating $repo..."
        (cd "$dir" && git pull --ff-only 2>/dev/null) &
    fi
done
wait

echo ""
echo "Ready!"
echo ""
cd "$SCRIPT_DIR"
claude --add-dir "$REPOS_DIR/surecart-wp" --add-dir "$REPOS_DIR/surecart" --add-dir "$REPOS_DIR/surecart-docs" --add-dir "$REPOS_DIR/surecart-support.wiki" --add-dir "$REPOS_DIR/wordpress-sdk"
