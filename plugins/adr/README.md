# ADR Plugin

Architecture Decision Records (ADR) tooling for Claude Code. Create ADRs with the MADR template, get suggestions for documenting architectural decisions, and automatically lint and regenerate the ADR index.

## What It Does

This plugin provides:

### Command: `/adr:create`

Create a new Architecture Decision Record using the MADR template:

```
/adr:create
```

The command will:
1. Detect the next ADR number automatically
2. Guide you through context, options, and decision
3. Create the file in `docs/adr/NNNN-title.md`

### Skill: ADR Suggestions (Auto-invoked)

When Claude detects significant architectural decisions being made, it will suggest documenting them as ADRs. This includes:

- Introducing new patterns, layers, or abstractions
- Adding significant dependencies or frameworks
- Making breaking changes to APIs
- Refactoring core modules
- Changing security or auth approaches

### Hooks (Auto-activated)

The plugin adds two `PostToolUse` hooks:

**Hook 1: ADR Linting**
- Triggers on Edit/Write for any `docs/adr/*.md` file
- Runs `markdownlint --fix` to auto-fix common issues
- Blocks the operation if unfixable lint errors remain

**Hook 2: ADR Log Regeneration**
- Triggers on Edit/Write for numbered ADR files (`docs/adr/NNNN-*.md`)
- Runs `adr-log` to regenerate the ADR index
- Excludes `template.md` from the index

## Prerequisites

### System Requirements

The hooks require Unix tools (`jq`, `grep`, `sed`) available on macOS and Linux. On Windows, use WSL or Git Bash.

### Node.js Dependencies

Add these to your project's `package.json`:

```json
{
  "devDependencies": {
    "adr-log": "^2.2.0",
    "markdownlint-cli": "^0.47.0"
  }
}
```

Then install:

```bash
npm install
```

## Project Structure

The plugin expects this directory structure:

```
your-project/
├── docs/
│   └── adr/
│       ├── 0001-record-architecture-decisions.md
│       ├── 0002-use-typescript.md
│       ├── template.md          # Excluded from index
│       └── README.md            # Generated index
├── node_modules/
│   └── .bin/
│       ├── markdownlint
│       └── adr-log
└── package.json
```

## ADR Naming Convention

- ADR files must be numbered: `NNNN-title-with-dashes.md`
- Example: `0001-use-react-for-frontend.md`
- The `template.md` file is excluded from linting regeneration

## Installation

```bash
/plugin install adr
```

## Behavior

| File Modified | Linting | Index Regeneration |
|---------------|---------|-------------------|
| `docs/adr/0001-*.md` | Yes | Yes |
| `docs/adr/template.md` | Yes | No |
| `docs/adr/README.md` | Yes | No |
| `src/other-file.md` | No | No |

## Customization

### ADR Directory Location

The plugin expects ADRs in `docs/adr/`. To use a different path, modify the grep patterns in the plugin.json:

```bash
# Current pattern
docs/adr/.*\.md$

# Custom path (e.g., architecture/decisions/)
architecture/decisions/.*\.md$
```

### Markdownlint Configuration

Create a `.markdownlint.json` in your project root:

```json
{
  "default": true,
  "MD013": false,
  "MD033": false
}
```

### ADR-log Configuration

The plugin runs with these options:
- `-i` - Update index in-place
- `-d <adr_dir>` - ADR directory
- `-e template.md` - Exclude template

For more options, see [adr-log documentation](https://github.com/adr/adr-log).

## Troubleshooting

### "markdownlint: command not found"

Ensure markdownlint-cli is installed:
```bash
npm install --save-dev markdownlint-cli
```

### "adr-log: command not found"

Ensure adr-log is installed:
```bash
npm install --save-dev adr-log
```

### Hook not triggering

1. Verify the plugin is installed: `/plugin list`
2. Check the file is in `docs/adr/`
3. For index regeneration, ensure the file is numbered (`NNNN-*.md`)

### Index not updating

The index regeneration only runs for numbered ADR files. Files like `template.md` and `README.md` won't trigger regeneration.

## Related Tools

- [adr-tools](https://github.com/npryce/adr-tools) - CLI for creating ADRs
- [adr-log](https://github.com/adr/adr-log) - Generate ADR index
- [markdownlint](https://github.com/DavidAnson/markdownlint) - Markdown linting
