#!/bin/bash
# ADR Index Regeneration Hook - updates README.md with ADR list
# Called by PostToolUse hook after Edit/Write on numbered ADR files

# Read tool input from stdin
file_path=$(jq -r '.tool_input.file_path' 2>/dev/null) || exit 0

# Only process numbered ADR files (0001-*.md pattern)
if ! echo "$file_path" | grep -qE 'docs/adr/[0-9]{4}-.*\.md$'; then
  exit 0
fi

# Extract project root and ADR directory
project_root=$(echo "$file_path" | sed -E 's|/docs/adr/.*||')
adr_dir=$(dirname "$file_path")
adr_log="$project_root/node_modules/.bin/adr-log"

# Check if adr-log is available
if [ ! -x "$adr_log" ]; then
  exit 0
fi

# Regenerate index, excluding template
"$adr_log" -i -d "$adr_dir" -e "template.md" 2>/dev/null

exit 0
