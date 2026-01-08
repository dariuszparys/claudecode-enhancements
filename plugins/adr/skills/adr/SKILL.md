---
name: adr
description: Suggest documenting significant architectural decisions as ADRs
user-invocable: false
when_to_use: |
  Use this skill when the conversation involves:
  - Introducing a new architectural pattern, layer, or abstraction
  - Adding a significant dependency or framework (ORM, auth library, state management)
  - Making breaking changes to APIs or interfaces
  - Refactoring core modules or restructuring the codebase
  - Adding infrastructure components (database, cache, queue, search)
  - Changing authentication, authorization, or security approach
  - Migrating between technologies or frameworks
  - Discussing trade-offs between multiple implementation approaches
  - Replacing an existing pattern with a new one
---

# ADR Suggestion Skill

When you detect an architectural decision being made, gently suggest documenting it.

## What Qualifies as ADR-Worthy

Decisions that:
- Affect multiple parts of the codebase
- Are difficult or costly to reverse
- Involve trade-offs between competing concerns
- Establish patterns that future code should follow
- Change how the system behaves architecturally

## What Does NOT Need an ADR

- Bug fixes
- Minor refactoring
- Adding features within existing patterns
- Routine dependency updates
- Code style changes

## How to Suggest

After completing significant architectural work, suggest:

> This change introduces [pattern/technology/approach]. Consider documenting this decision with an ADR to capture the context and reasoning. You can run `/adr:create` to create one.

## Suggestion Guidelines

- Suggest once per decision, not repeatedly
- Frame as optional, not required
- Only suggest after the work is done, not before
- Include what makes this ADR-worthy (e.g., "introduces a new caching layer")
- Keep suggestions brief - one sentence plus the command reference
