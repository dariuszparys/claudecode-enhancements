# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.1.0] - 2026-01-08

### Added
- Support for Claude Code 2.1.0 features
- `user-invocable: false` to skills (hide from `/` menu)
- `once: true` to ADR index regeneration hook
- CHANGELOG.md for version tracking

### Changed
- `allowed-tools` format from comma-separated to YAML list style

## [1.0.0] - Initial Release

### Added
- work-items plugin: analyze, optimize, tasks commands
- dp-tools plugin: create-claude-md, create-rules commands
- azure-boards plugin: Azure DevOps integration skill
- adr plugin: ADR creation, auto-linting, index regeneration
