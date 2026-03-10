#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPOS_DIR="$SCRIPT_DIR/.repos"

echo "Updating SureCart Support..."
# Update the support repo itself (picks up new CLAUDE.md, skills, guides)
(cd "$SCRIPT_DIR" && git pull --ff-only 2>/dev/null)

# Update all code repos in parallel
for repo in surecart-wp surecart surecart-docs surecart-support.wiki; do
    (cd "$REPOS_DIR/$repo" && git pull --ff-only 2>/dev/null) &
done
wait

echo "Ready!"
echo ""
cd "$SCRIPT_DIR"
claude --add-dir "$REPOS_DIR/surecart-wp" --add-dir "$REPOS_DIR/surecart" --add-dir "$REPOS_DIR/surecart-docs" --add-dir "$REPOS_DIR/surecart-support.wiki"
