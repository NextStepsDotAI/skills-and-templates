# Skills and Templates Repository

A collection of reusable skills, hooks, workflows, and templates for setting up development projects with common best practices.

## Overview

This repository contains self-contained skill packages that can be downloaded and installed into any project. Each skill provides infrastructure, configurations, and templates to solve a specific problem.

### Design Philosophy

- **No nested repos** — Skills are downloaded, not cloned as submodules or subtrees
- **No git overhead** — Use the `download-skill.sh` script to import without git dependencies
- **Reusable** — Each skill is self-contained and can be used independently
- **Well-documented** — Every skill includes README, spec, and templates
- **Future-proof** — Directory structure supports many skills

## Available Skills

### 1. git-workflow-setup

Complete git workflow enforcement system with local hooks and GitHub Actions workflows.

**What it does:**
- Prevents direct commits and pushes to main
- Enforces pull request workflow
- Provides developer warnings about branch sync status

**Installation:**
```bash
bash download-skill.sh git-workflow-setup
```

**Files included:**
- Git hooks (pre-commit, pre-push, pre-merge-commit, post-merge)
- GitHub Actions workflows (enforce-pr-workflow, block-logs-merge)
- CLAUDE.md template for documentation
- Comprehensive README and spec

See [git-workflow-setup/README.md](git-workflow-setup/README.md) for details.

## How to Use Skills

### Option 1: Download a Skill

```bash
bash download-skill.sh <skill-name>
```

This downloads the skill from the skills-and-templates repository and installs it locally.

**Example:**
```bash
bash download-skill.sh git-workflow-setup
```

**What it does:**
1. Clones the repository (sparse checkout for efficiency)
2. Extracts the specific skill
3. Copies files to target directories
4. Shows post-installation setup steps
5. Cleans up temporary files

### Option 2: Manual Installation

For a specific skill, you can also:

1. Download individual files from GitHub web interface
2. Copy them to appropriate directories in your project
3. Follow the skill's README for setup

## Repository Structure

```
skills-and-templates/
├── README.md                 (this file)
├── download-skill.sh         (installation script)
├── git-workflow-setup/       (skill: git workflow enforcement)
│   ├── README.md            (skill documentation)
│   ├── spec.yaml            (skill specification)
│   ├── hooks/               (git hooks)
│   │   ├── pre-commit
│   │   ├── pre-push
│   │   ├── pre-merge-commit
│   │   └── post-merge
│   ├── workflows/           (GitHub Actions)
│   │   ├── enforce-pr-workflow.yml
│   │   └── block-logs-merge.yml
│   └── templates/           (template files)
│       └── CLAUDE.md.template
├── [future-skill-2]/        (future skill)
├── [future-skill-3]/        (future skill)
└── ...
```

## Skill Structure

Each skill directory should contain:

- **README.md** — Documentation and installation guide
- **spec.yaml** — Skill specification (name, version, components)
- **hooks/** — Git hooks (if applicable)
- **workflows/** — GitHub Actions workflows (if applicable)
- **templates/** — Template files (.template extension)
- **scripts/** — Setup/installation scripts (if needed)

## Creating New Skills

To add a new skill to this repository:

1. Create a directory: `skills-and-templates/<skill-name>/`
2. Add required files:
   - `README.md` with usage instructions
   - `spec.yaml` with skill definition
   - Component directories (hooks, workflows, templates, scripts)
3. Test the `download-skill.sh` script with your skill
4. Add skill to this README's "Available Skills" section
5. Commit and push

### Example spec.yaml

```yaml
name: your-skill-name
version: 1.0.0
description: |
  One-line description of what this skill does.
  
  Multi-line explanation of the problem it solves
  and how it works.

components:
  - type: git-hooks
  - type: github-actions
  - type: templates

installation:
  - copy files to target directories
  - run setup commands
  - update documentation

documentation:
  - README.md
  - Templates
```

## Best Practices

### For Users (Installing Skills)

1. **Review before installing** — Read the skill's README and spec
2. **Test in a feature branch** — Don't merge directly to main
3. **Commit the changes** — Make them part of your repository
4. **Update documentation** — Merge CLAUDE.md templates into your docs
5. **Customize as needed** — Modify hooks/workflows for your project

### For Skill Authors

1. **Keep skills focused** — One problem per skill
2. **Include documentation** — Every file should be clear
3. **Provide templates** — Help projects adopt the skill
4. **Test the download script** — Verify files extract correctly
5. **Use consistent naming** — Follow established patterns
6. **Version your skills** — Track changes in spec.yaml

## Script Usage

### download-skill.sh

```bash
bash download-skill.sh <skill-name>
```

**Requirements:**
- Git installed and in PATH
- Bash shell
- Write access to current directory

**Options:**
- No arguments — Shows usage and available skills
- `<skill-name>` — Downloads and installs specific skill

**Example:**
```bash
cd my-project
bash download-skill.sh git-workflow-setup
git add .githooks .github/workflows CLAUDE.md
git commit -m "Add git workflow enforcement"
```

## FAQ

### Can I modify a skill after installing it?

Yes! Once installed, the files are part of your project. Modify them to fit your needs.

### Do I need git to download a skill?

Yes, the download script uses git. However, the downloaded files don't create nested repos.

### Can I use multiple skills together?

Yes! Skills are designed to be independent. Download multiple skills and they'll coexist.

### What if a skill conflicts with my setup?

Review the skill's README before installing. If conflicts arise, don't merge the files or modify the skill to suit your needs.

### How do I report issues or suggest improvements?

Open an issue in the [skills-and-templates repository](https://github.com/NextStepsDotAI/skills-and-templates).

## Contributing

We welcome contributions! To add a skill:

1. Create a pull request with your skill directory
2. Follow the structure and naming conventions
3. Include comprehensive documentation
4. Ensure download-skill.sh works with your skill
5. Provide examples and best practices

## License

These skills and templates are provided as-is for educational and development purposes.

## Support

- See individual skill README files for skill-specific help
- Check spec.yaml for technical details
- Review download-skill.sh for installation details

## Next Steps

1. Explore the [git-workflow-setup skill](git-workflow-setup/README.md)
2. Try installing it: `bash download-skill.sh git-workflow-setup`
3. Use the template to create more skills
4. Contribute your own skills!
