# DP Tools Plugin

Tools for creating and maintaining Claude Code project documentation. Generate CLAUDE.md files for AI agent onboarding and modular rules files for path-specific conventions.

## What It Does

This plugin provides two commands for setting up Claude Code project documentation.

### Command: `/dp:create-claude-md`

Generate or update a CLAUDE.md file following best practices:

```
/dp:create-claude-md
```

Features:
- Auto-detects context (repo root vs subdirectory)
- Explores directory structure and existing documentation
- Generates lean, focused content (60-100 lines for root, 30-50 for subdirectory)
- Uses progressive disclosure with pointers to detailed docs

The command creates a CLAUDE.md that covers:
- Project identity and tech stack
- Essential commands
- Project structure (non-obvious parts only)
- Universal rules and domain context
- Pointers to external docs

### Command: `/dp:create-rules`

Create modular Claude Code rules files in `.claude/rules/`:

```
/dp:create-rules
```

Features:
- Analyzes project structure for rule candidates
- Creates topic-specific rule files (typescript.md, testing.md, api.md)
- Supports path-scoped rules with frontmatter
- Organizes rules in subdirectories for larger projects

Output structure:
```
.claude/
├── CLAUDE.md           # Main project memory
└── rules/
    ├── typescript.md   # Language conventions
    ├── testing.md      # Testing standards
    └── api.md          # API-specific (paths: src/api/**)
```

## When to Use Each Command

| Use Case | Command |
|----------|---------|
| Project overview, stack, commands | `/dp:create-claude-md` |
| Path-specific conventions (API, tests) | `/dp:create-rules` |
| Large project with many conventions | `/dp:create-rules` |
| New project setup | Both |

## Installation

```bash
/plugin install dp-tools
```

## Usage Examples

### Creating a Root CLAUDE.md

```
User: /dp:create-claude-md
Claude: [Explores project, generates comprehensive CLAUDE.md]
```

### Creating a Subdirectory CLAUDE.md

```
cd packages/api
User: /dp:create-claude-md
Claude: [Reads root CLAUDE.md, creates package-specific additions only]
```

### Creating Rules Files

```
User: /dp:create-rules
Claude: [Analyzes codebase, suggests 2-4 rules, creates approved files]
```

## Best Practices

### CLAUDE.md Guidelines

- Keep under 100 lines (60-100 ideal)
- Every instruction should be universally applicable
- Use pointers to docs instead of embedding content
- Include domain knowledge that can't be inferred from code
- Don't duplicate linter rules (use Biome, ESLint instead)

### Rules Guidelines

- One topic per file (20-50 lines ideal)
- Use path scoping sparingly
- Cross-reference related rules
- Be specific, not generic

## Related

- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins.md)
- [CLAUDE.md Best Practices](https://code.claude.com/docs/en/project-configuration.md)
