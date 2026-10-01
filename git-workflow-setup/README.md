# Git Workflow Setup Skill

Complete git workflow enforcement system with local hooks and GitHub Actions workflows.

## What It Does

Prevents direct commits and pushes to main, enforces pull request workflow, and provides developer warnings about branch sync status.

**Defense-in-depth approach:**
- Local git hooks catch mistakes before pushing
- GitHub Actions workflows catch any bypasses on the server
- Post-merge hook warns developers about sync status

## Components

### Local Git Hooks (`.githooks/`)

- **pre-commit** — Blocks `git commit` directly to main
- **pre-push** — Blocks `git push` directly to main  
- **pre-merge-commit** — Blocks merging `feature/claude-logs` into other branches
- **post-merge** — Warns if main is ahead or remote is ahead of local

Enable with: `git config core.hooksPath .githooks`

### GitHub Actions Workflows (`.github/workflows/`)

- **enforce-pr-workflow.yml** — Detects and blocks direct commits on main
  - Allows: PR merges, initial commit
  - Rejects: direct commits outside of PRs

- **block-logs-merge.yml** — Prevents `feature/claude-logs` from merging into other branches
  - Allows: other branches merging into logs
  - Rejects: logs merging out

## Installation

1. Extract this skill into your project
2. Copy files to target directories:
   ```bash
   cp -r git-workflow-setup/hooks/* .githooks/
   cp -r git-workflow-setup/workflows/* .github/workflows/
   ```

3. Enable git hooks:
   ```bash
   git config core.hooksPath .githooks
   chmod +x .githooks/*
   ```

4. Add documentation to CLAUDE.md:
   ```bash
   cat git-workflow-setup/templates/CLAUDE.md >> CLAUDE.md
   ```

5. Commit:
   ```bash
   git add .githooks .github/workflows CLAUDE.md
   git commit -m "Add git workflow enforcement"
   ```

## Workflow

1. Create a feature branch from main
2. Commit locally (blocked from main)
3. Push branch (blocked from main)
4. Open PR on GitHub
5. Merge PR (workflows validate and allow)
6. Other branches receive updates via `git merge origin/main`

## Bypass Options

Each layer can be bypassed if absolutely necessary:
- `git commit --no-verify` (skip pre-commit hook)
- `git push --no-verify` (skip pre-push hook)
- `git merge --no-verify` (skip pre-merge-commit hook)

**Not recommended** unless you have a good reason.

## Best Practices

- Keep main as the single source of truth
- All changes go through pull requests
- Merge, don't force-push
- Run `git pull` regularly to stay current
- Pay attention to post-merge warnings

## Files

- `spec.yaml` — Skill specification
- `hooks/` — Git hooks
- `workflows/` — GitHub Actions workflows
- `templates/` — Template files for your project

## Support

This skill follows industry best practices for workflow enforcement.
Based on Git Flow and GitHub Flow standards.
