# Work Items Plugin

Platform-agnostic tools for analyzing, optimizing, and breaking down work items for LLM-assisted development. Works with GitHub Issues, Jira, Azure DevOps, Linear, and any issue tracker.

## What It Does

This plugin helps you work efficiently with work items by:
- Checking if work items are ready for development
- Compressing work items for token-efficient LLM context
- Breaking down features into sequential implementation tasks

### Command: `/work-items:analyze`

Check if a work item is ready for development:

```
/work-items:analyze https://github.com/org/repo/issues/123
```

Evaluates:
- **Title**: Descriptive, clear, no vague terms
- **Description**: Explains what and why, provides context
- **Acceptance Criteria**: Specific, testable conditions

Returns a structured analysis with pass/fail for each area and recommendations.

### Command: `/work-items:optimize`

Transform a work item into token-efficient LLM format:

```
/work-items:optimize
```

Transformations:
- Compresses file paths using glob patterns
- Removes obvious acceptance criteria (tests pass, deployment succeeds)
- Uses terse language (no articles, no filler)
- Outputs ~100 tokens from ~280 token input

Output format:
```markdown
# {ID}: {title}

## Context
{1-2 sentence summary}

## Files
- {paths with glob patterns}

## Changes
1. {file}: {action}

## Verify
- {non-obvious verification step}
```

### Command: `/work-items:tasks`

Generate implementation task breakdown:

```
/work-items:tasks 12345
```

Creates sequential tasks following:
1. **Infrastructure/Config first** (env vars, config files)
2. **Core changes second** (main logic, modules)
3. **Dependent files third** (routes, integrations)
4. **Verification last** (manual checks)

Each task includes:
- Files to modify
- Specific actions
- How to test/verify

### Skill: Work Items (Auto-invoked)

The work-items skill is automatically invoked when you:
- Paste a work item, issue, or ticket from any system
- Ask about work item readiness or completeness
- Need to break down a feature into tasks
- Want to optimize content for LLM context windows

## Installation

```bash
/plugin install work-items
```

## Input Formats

All commands accept work items via:

| Format | Example |
|--------|---------|
| URL | `https://github.com/org/repo/issues/123` |
| Pasted content | Copy work item details into chat |
| File path | Path to file containing work item |
| Optimized format | Output from `/work-items:optimize` |

## Usage Examples

### Analyze Before Starting Work

```
User: /work-items:analyze https://github.com/myorg/myrepo/issues/456

Claude: ## Work Item Analysis

### Status: NEEDS WORK

**Title**: Pass - "Add user authentication with OAuth2"
**Description**: Pass - Clear scope and business value
**Acceptance Criteria**: Fail - Missing specific testable conditions

### Recommendations
- Add specific OAuth providers to support
- Define session timeout behavior
- Specify error handling for failed auth
```

### Optimize for Context Window

```
User: [Pastes long work item with 15 acceptance criteria]
/work-items:optimize

Claude: # 1234: OAuth2 Authentication

## Context
Add OAuth2 login with Google/GitHub. Session-based auth with JWT tokens.

## Files
- src/auth/{oauth,session,middleware}.ts
- src/config/auth.ts

## Changes
1. auth.ts: OAuth2 client setup for Google, GitHub
2. session.ts: JWT token generation, validation
3. middleware.ts: Auth guard for protected routes

## Verify
- OAuth redirect works for both providers
- Invalid tokens return 401
- Session expires after 24h
```

### Generate Implementation Tasks

```
User: /work-items:tasks

Claude: # Tasks for 1234: OAuth2 Authentication

## Summary
Add OAuth2 authentication with Google and GitHub. 5 tasks.

## Prerequisites
- [ ] Google Cloud Console OAuth credentials
- [ ] GitHub OAuth App created

---

## Task 1: Configure OAuth environment
**Files**: src/config/auth.ts, .env.example
**Do**:
- Add GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET
- Add GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET
**Test**:
- Config loads without errors

---

## Task 2: Implement OAuth clients
...
```

## File Path Compression

The optimize command compresses multiple paths:

| Before | After |
|--------|-------|
| `routes/dev.bicep`, `routes/test.bicep`, `routes/prod.bicep` | `routes/{dev,test,prod}.bicep` |
| `src/components/Button.tsx`, `src/components/Input.tsx` | `src/components/{Button,Input}.tsx` |

## Related

- [azure-boards plugin](../azure-boards/README.md) - Azure DevOps-specific integration
