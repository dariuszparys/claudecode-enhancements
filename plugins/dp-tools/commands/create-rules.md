---
description: Create modular Claude Code rules files in .claude/rules/
argument-hint: "[topic]"
allowed-tools:
  - Bash(find:*)
  - Bash(tree:*)
  - Bash(ls:*)
  - Bash(git rev-parse:*)
  - Bash(pwd:*)
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

# Task: Create Claude Code Rules

You are helping me create modular rules files for Claude Code. Rules are topic-specific instruction files stored in `.claude/rules/`.

## When to Use Rules vs CLAUDE.md

| Use Case | Approach |
|----------|----------|
| Project overview, stack, commands | CLAUDE.md |
| Path-specific conventions (API, tests) | Rules with `paths:` frontmatter |
| Large project with many conventions | Rules organized in subdirectories |
| Shared rules across projects | Rules (can be symlinked) |

## Step 1: Analyze the Project

```bash
# Check if rules directory exists
ls -la .claude/rules/ 2>/dev/null || echo "No rules directory yet"

# Check existing CLAUDE.md
cat .claude/CLAUDE.md 2>/dev/null || cat CLAUDE.md 2>/dev/null || echo "No CLAUDE.md found"

# Understand project structure
tree -L 2 -d 2>/dev/null || find . -type d -maxdepth 2
```

## Step 2: Identify Rule Candidates

Look for areas that would benefit from dedicated rules:

- **Language-specific**: `typescript.md`, `python.md`, `go.md`
- **Layer-specific**: `api.md`, `frontend.md`, `database.md`
- **Practice-specific**: `testing.md`, `security.md`, `logging.md`
- **Domain-specific**: `payments.md`, `auth.md`, `notifications.md`

## Step 3: Choose Rule Type

### A. Global Rules (no paths)
Apply to all files in the project:

```markdown
# Testing Standards

- Use descriptive test names: `test_<function>_<scenario>_<expected>`
- Each test file must have a corresponding source file
- Mock external services, never call real APIs in tests
```

### B. Path-Scoped Rules (with paths frontmatter)
Apply only to matching files:

```markdown
---
paths: src/api/**/*.ts
---

# API Development Rules

- All endpoints must validate input with zod schemas
- Use standard error response format from `lib/errors`
- Rate limiting required for public endpoints
```

### Path Pattern Examples

| Pattern | Matches |
|---------|---------|
| `**/*.ts` | All TypeScript files |
| `src/api/**/*.ts` | API TypeScript files only |
| `src/**/*.{ts,tsx}` | All TS/TSX in src |
| `tests/**/*.test.ts` | Test files only |
| `{src,lib}/**/*.ts` | Multiple directories |

## Step 4: Create Rules Structure

For a typical project, suggest this structure:

```
.claude/
├── CLAUDE.md           # Main project memory (overview, stack, commands)
└── rules/
    ├── typescript.md   # Language conventions
    ├── testing.md      # Testing standards
    ├── api.md          # API-specific (paths: src/api/**)
    └── database.md     # Database conventions
```

For larger projects with many rules:

```
.claude/
├── CLAUDE.md
└── rules/
    ├── languages/
    │   ├── typescript.md
    │   └── python.md
    ├── layers/
    │   ├── api.md
    │   ├── frontend.md
    │   └── database.md
    └── practices/
        ├── testing.md
        └── security.md
```

## Rule Writing Guidelines

### Keep Rules Focused
- One topic per file
- 20-50 lines ideal
- Use descriptive filenames

### Use Path Scoping Sparingly
- Only when rules genuinely don't apply project-wide
- Prefer global rules when possible (simpler)

### Avoid Duplication
- Don't repeat what's in CLAUDE.md
- Cross-reference: "See `security.md` for auth requirements"

### Be Specific
Bad: "Write clean code"
Good: "Functions must have max 20 lines, extract helpers for complex logic"

## Output Format

For each rule file, provide:

```markdown
## Rule: {filename}

**Scope**: Global / Path-scoped to `{pattern}`
**Purpose**: {one sentence}

### Content

\`\`\`markdown
{rule content}
\`\`\`
```

## Your Task

1. Analyze the project structure and existing CLAUDE.md
2. Identify 2-4 rule candidates based on the codebase
3. Present each rule with its scope and purpose
4. Ask which rules to create
5. Create `.claude/rules/` directory if needed
6. Write the approved rule files

## After Creating Rules

Remind the user:
- Rules are automatically loaded by Claude Code
- No configuration needed after creating the files
- Rules can be version controlled with the project
- Use `paths:` frontmatter for path-specific rules
