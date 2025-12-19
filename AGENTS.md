# Repository Guidelines

## Project Structure & Module Organization
- `.claude-plugin/marketplace.json` lists marketplace plugins.
- `plugins/<name>/` contains a single plugin with its own `.claude-plugin/plugin.json` manifest.
- `plugins/<name>/commands/<namespace>/<command>.md` holds command prompts with YAML frontmatter.
- `plugins/<name>/skills/<namespace>/SKILL.md` defines auto-invoked skills.
- Each plugin has a `plugins/<name>/README.md` with usage and setup notes.

## Build, Test, and Development Commands
- No build or test runner is defined in this repo.
- Recommended checks:
  - `tree -L 3 plugins/` to verify structure and placement.
  - `rg "plugin.json|SKILL.md" plugins/` to confirm manifests and skills are present.
- Hooks in `plugins/adr/.claude-plugin/plugin.json` rely on `markdownlint` and `adr-log` in the *consuming* project; validate those in that project’s environment.

## Coding Style & Naming Conventions
- Use 2-space indentation for JSON and Markdown lists.
- Command files use YAML frontmatter with `description` and `allowed-tools` before the body.
- Naming patterns:
  - Plugin folder: `plugins/<kebab-name>/`
  - Command file: `commands/<namespace>/<verb>.md` (e.g., `commands/adr/create.md`)
  - Skill file: `skills/<namespace>/SKILL.md`
- Keep command prompts focused on a single task and documented in the plugin README.

## Testing Guidelines
- No automated tests or coverage requirements are configured.
- For changes to hooks, manually sanity-check the shell snippets and regex matchers in the relevant `plugin.json`.

## Commit & Pull Request Guidelines
- Commit history uses Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`). Follow that pattern.
- PRs should include:
  - A short description of the plugin change and user impact.
  - Updates to `plugins/<name>/README.md` and `.claude-plugin/marketplace.json` when adding or renaming plugins.
  - Any setup notes if new external tools or hooks are introduced.

## Agent-Specific Notes
- Treat this repo as a plugin marketplace: changes should be additive and documented.
- Avoid introducing repo-level dependencies unless they are required for marketplace operation.
