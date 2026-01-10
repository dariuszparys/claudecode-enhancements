---
description: Transform a work item into LLM-optimized format for efficient context usage
argument-hint: "<url|path|paste>"
allowed-tools:
  - Read
  - WebFetch
---

Transform a work item into a token-efficient format optimized for LLM context windows.

## Input

Provide the work item via one of:
- **URL**: $ARGUMENTS (e.g., "https://github.com/org/repo/issues/123")
- **Pasted content**: Copy the work item details into the chat
- **File path**: Path to a file containing work item details

## Output Structure

```markdown
# {Work Item ID}: {title}

## Context
{1-2 sentence summary}

## Files
- {file paths with glob patterns}

## Changes
1. {file}: {action}

## Verify
- {non-obvious verification step}
```

## Transformation Rules

### 1. Title
- Keep as-is (titles are usually already concise)
- Output: `# {ID}: {title}`

### 2. Description to Context + Files + Changes

**Context**: Compress background/architecture to 1-2 sentences
**Files**: Extract file paths, compress with glob patterns
**Changes**: Convert scope items to `file: action` format

### 3. Acceptance Criteria to Verify

**Remove** obvious/implicit criteria:
- "Deployment succeeds"
- "No downtime"
- "Tests pass"
- "Code reviewed"
- "PR merged"

**Keep** non-obvious verification:
- Specific HTTP status codes
- Portal/UI status checks
- Security constraints
- Integration behaviors

### 4. File Path Compression

| Before | After |
|--------|-------|
| `routes/dev-routes.bicep`, `routes/test-routes.bicep`, `routes/prod-routes.bicep` | `routes/{dev,test,prod}-routes.bicep` |
| `src/components/Button.tsx`, `src/components/Input.tsx` | `src/components/{Button,Input}.tsx` |

### 5. Changes = Actions

Each entry: `{file}: {what to change}`

Bad: "Update the container app configuration"
Good: "container-app.bicep: set `ingress.external` = false"

### 6. Terse Language

- No articles ("the", "a") unless needed for clarity
- No filler ("In order to", "This will")
- Use arrows: "external -> internal", "HTTP -> HTTPS"

## Example Transformation

### Before (~280 tokens)
```
Description: Change Container Apps ingress from external to internal,
update Front Door origins to use Private Link.

Scope:
- Change Container Apps ingress from external to internal
- Update Front Door origins to use Private Link

Files to modify:
- infra/bicep/resources/container-app.bicep
- infra/bicep/resources/front-door-route.bicep
- infra/bicep/routes/dev-routes.bicep
- infra/bicep/routes/test-routes.bicep
- infra/bicep/routes/prod-routes.bicep

ACs:
- Container Apps ingress is configured as internal
- Front Door origins updated to use Private Link
- Direct access returns 403/404
- Deployment succeeds without downtime
```

### After (~100 tokens)
```markdown
# 1357: Container Apps Internal Ingress

## Context
Container Apps -> internal ingress. External traffic via Front Door + Private Link.

## Files
- infra/bicep/resources/container-app.bicep
- infra/bicep/resources/front-door-route.bicep
- infra/bicep/routes/{dev,test,prod}-routes.bicep

## Changes
1. container-app.bicep: `ingress.external` = false
2. front-door-route.bicep: origins use Private Link
3. *-routes.bicep: consistent Private Link config

## Verify
- Direct URL -> 403/404
- Front Door URL -> 200
- Private Link status = Approved
```

## Related Commands

- `/work-items:analyze` — Check if work item is ready for development first
- `/work-items:tasks` — Generate implementation task breakdown from optimized format
