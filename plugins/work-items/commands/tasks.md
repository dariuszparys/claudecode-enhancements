---
description: Generate implementation tasks from a work item
argument-hint: "<url|path|paste>"
allowed-tools:
  - Read
  - WebFetch
---

Generate a task breakdown from a work item, optimized for sequential Claude Code execution.

## Input

Provide the work item via one of:
- **URL**: $ARGUMENTS (e.g., "https://github.com/org/repo/issues/123")
- **Pasted content**: Copy the work item details into the chat
- **Optimized format**: Output from `/work-items:optimize`

## Task Generation Rules

### Task Granularity
- **1 task = 1 logical change** that can be committed independently
- Each task should take ~5-30 min of Claude Code work
- Group related file changes if they must be atomic

### Task Sequencing
1. **Infrastructure/Config first** (env vars, config files, dependencies)
2. **Core changes second** (main logic, modules)
3. **Dependent files third** (routes, integrations, consumers)
4. **Verification last** (manual checks, cleanup)

### Include in Each Task
- Exact file paths
- Specific property/value changes where known
- Command or method to test/verify

### Exclude from Tasks
- "Review code" (implicit)
- "Test deployment" (part of each task's Test section)
- Generic "update documentation" (be specific or omit)

## Output Format

```markdown
# Tasks for {ID}: {title}

## Summary
{1-line: what we're building, n tasks total}

## Prerequisites
- [ ] {any setup needed before starting}

---

## Task 1: {title}
**Files**: {path}
**Do**:
- {action}
**Test**:
- {verification}

---

## Task 2: {title}
...
```

## Task Format

```markdown
## Task {n}: {brief title}

**Files**: {file(s) to modify}

**Do**:
- {specific action 1}
- {specific action 2}

**Test**:
- {how to verify this task}
```

## Example Output

```markdown
# Tasks for 1357: Container Apps Internal Ingress

## Summary
Switch Container Apps to internal ingress with Front Door Private Link. 4 tasks.

## Prerequisites
- [ ] Front Door Premium SKU (required for Private Link)
- [ ] Managed Identity for Private Link approval

---

## Task 1: Configure internal ingress
**Files**: infra/bicep/resources/container-app.bicep
**Do**:
- Set `ingress.external` = `false`
- Ensure `ingress.targetPort` unchanged
**Test**:
- Build succeeds
- `az containerapp show` shows internal ingress

---

## Task 2: Add Private Link to Front Door origin
**Files**: infra/bicep/resources/front-door-route.bicep
**Do**:
- Add `privateLinkLocation` property to origin
- Add `privateLinkResourceId` pointing to Container App
- Set `privateEndpointStatus` to monitor approval
**Test**:
- Deploy to dev, check Portal -> Front Door -> Origins -> Private Link status

---

## Task 3: Update environment routes
**Files**: infra/bicep/routes/{dev,test,prod}-routes.bicep
**Do**:
- Reference updated front-door-route module
- Ensure consistent params across environments
**Test**:
- `az deployment group what-if` for each environment

---

## Task 4: Verify external access blocked
**Files**: (none - verification only)
**Do**:
- Deploy to dev environment
**Test**:
- `curl https://<container-app-url>` -> expect 403/404
- `curl https://<frontdoor-url>` -> expect 200
- Portal: Private Link = "Approved"
```

## Related Commands

- `/work-items:analyze` — Check if work item is ready for development first
- `/work-items:optimize` — Transform to LLM-optimized format (recommended input for this command)
