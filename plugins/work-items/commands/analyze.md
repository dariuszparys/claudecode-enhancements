---
description: Analyze a work item to determine if it's ready for development
argument-hint: "<url|path|paste>"
allowed-tools:
  - Read
  - WebFetch
---

Analyze a work item (GitHub Issue, Jira ticket, Azure DevOps PBI, etc.) for development readiness.

## Input

Provide the work item via one of:
- **URL**: $ARGUMENTS (e.g., "https://github.com/org/repo/issues/123")
- **Pasted content**: Copy the work item details into the chat
- **File path**: Path to a file containing work item details

## Steps

1. Fetch or parse the work item content
2. Analyze against the **completeness criteria** below

## Completeness Criteria

### Title Analysis
- [ ] Is descriptive (not too short, > 5 words typically)
- [ ] Clearly indicates what feature/change is needed
- [ ] Avoids vague terms like "fix bug", "update code", "improvements"

### Description Analysis
- [ ] Exists and is not empty
- [ ] Explains **what** needs to be done
- [ ] Explains **why** it's needed (business value/context)
- [ ] Provides enough context for a developer to understand the scope

### Acceptance Criteria Analysis
- [ ] Acceptance criteria / definition of done is present
- [ ] Contains specific, testable conditions
- [ ] Uses clear language (e.g., "Given/When/Then" or bullet points)
- [ ] Defines what "done" looks like

## Output Format

Provide a structured analysis:

```markdown
## Work Item Analysis

### Status: [READY / NEEDS WORK]

**Title**: [Pass/Fail] - [Brief explanation]
**Description**: [Pass/Fail] - [Brief explanation]
**Acceptance Criteria**: [Pass/Fail] - [Brief explanation]

### Recommendations (if NEEDS WORK)
- List specific improvements needed
- Suggest example text where helpful

### Summary
One sentence summarizing the work item readiness.
```

## Related Commands

- `/work-items:optimize` — Transform to LLM-optimized format for efficient context usage
- `/work-items:tasks` — Generate implementation task breakdown
