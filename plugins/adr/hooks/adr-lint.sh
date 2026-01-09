#!/bin/bash
# ADR Linting Hook - runs markdownlint on ADR files
# Called by PostToolUse hook after Edit/Write operations

# Read tool input from stdin
file_path=$(jq -r '.tool_input.file_path' 2>/dev/null) || exit 0

# Only process ADR markdown files
if ! echo "$file_path" | grep -qE 'docs/adr/.*\.md$'; then
  exit 0
fi

# Extract project root from file path
project_root=$(echo "$file_path" | sed -E 's|/docs/adr/.*||')
lint="$project_root/node_modules/.bin/markdownlint"

# Check if markdownlint is available
if [ ! -x "$lint" ]; then
  echo "Note: markdownlint not found, skipping lint" >&2
  exit 0
fi

# Run lint with auto-fix
"$lint" --fix "$file_path" 2>/dev/null

# Check for remaining errors
errors=$("$lint" "$file_path" 2>&1)
if [ $? -ne 0 ]; then
  jq -n --arg err "$errors" '{decision:"block",reason:("Markdown lint errors:\n" + $err)}'
  exit 2
fi

exit 0
