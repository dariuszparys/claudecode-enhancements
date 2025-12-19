---
allowed-tools: Bash(find:*), Bash(ls:*), Read, Write
description: Create a new Architecture Decision Record using the standard MADR template
---

# Task: Create New ADR

Create a new Architecture Decision Record (ADR) in the project's `docs/adr/` directory.

## Step 1: Detect ADR Directory and Next Number

```bash
# Find existing ADRs and determine next number
find . -path "*/docs/adr/[0-9][0-9][0-9][0-9]-*.md" -type f 2>/dev/null | sort | tail -1
```

If no ADRs exist, start with `0001`. Otherwise, increment the highest number.

## Step 2: Gather Context

Ask the user for:
1. **Title**: Short description of the decision (will become filename and heading)
2. **Context**: What is the situation? What problem needs solving?
3. **Options**: What alternatives were considered? (minimum 2-3)
4. **Decision**: Which option was chosen and why?

## Step 3: Create the ADR

Use this template structure:

```markdown
# [short title of solved problem and solution]

- Status: [proposed | rejected | accepted | deprecated | superseded by [ADR-0005](0005-example.md)]
- Deciders: [list everyone involved in the decision]
- Date: [YYYY-MM-DD when the decision was last updated]

Technical Story: [description | ticket/issue URL] <!-- optional -->

## Context and Problem Statement

[Describe the context and problem statement, e.g., in free form using two to
three sentences. You may want to articulate the problem in form of a question.]

## Decision Drivers <!-- optional -->

- [driver 1, e.g., a force, facing concern, ...]
- [driver 2, e.g., a force, facing concern, ...]
- ...

## Considered Options

- [option 1]
- [option 2]
- [option 3]
- ...

## Decision Outcome

Chosen option: "[option 1]", because [justification. e.g., only option, which
meets k.o. criterion decision driver | which resolves force force | ... | comes
out best (see below)].

### Positive Consequences <!-- optional -->

- [e.g., improvement of quality attribute satisfaction, follow-up decisions
  required, ...]
- ...

### Negative Consequences <!-- optional -->

- [e.g., compromising quality attribute, follow-up decisions required, ...]
- ...

## Pros and Cons of the Options <!-- optional -->

### [option 1]

[example | description | pointer to more information | ...] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- ...

### [option 2]

[example | description | pointer to more information | ...] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- ...

### [option 3]

[example | description | pointer to more information | ...] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- ...

## Links <!-- optional -->

- [Link type] [Link to ADR]
- <!-- example: Refined by [ADR-0005](0005-example.md) -->
- ...
```

## Naming Convention

- Filename: `NNNN-title-with-dashes.md`
- Example: `0001-use-react-for-frontend.md`
- Keep titles concise but descriptive

## Output Location

Write to: `docs/adr/NNNN-<title>.md`

If `docs/adr/` doesn't exist, create it first.

## After Creation

The ADR plugin hooks will automatically:
1. Lint the new ADR file with markdownlint
2. Regenerate the ADR index (README.md) using adr-log

## Status Values

- **proposed**: Decision is under discussion
- **accepted**: Decision has been approved
- **rejected**: Decision was considered but not accepted
- **deprecated**: Decision is no longer relevant
- **superseded by [ADR-NNNN]**: Replaced by a newer decision
