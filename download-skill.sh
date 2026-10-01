#!/bin/bash
# Download and install a skill from the skills-and-templates repository
# Usage: bash download-skill.sh <skill-name>
# Example: bash download-skill.sh git-workflow-setup

set -e

REPO_URL="https://github.com/NextStepsDotAI/skills-and-templates.git"
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Validate arguments
if [ $# -eq 0 ]; then
    echo "Usage: bash download-skill.sh <skill-name>"
    echo ""
    echo "Available skills:"
    echo "  - git-workflow-setup"
    echo ""
    echo "Example:"
    echo "  bash download-skill.sh git-workflow-setup"
    exit 1
fi

SKILL_NAME="$1"
PROJECT_ROOT="$(pwd)"
SKILL_DIR="$TEMP_DIR/skills-and-templates/$SKILL_NAME"

echo "📥 Downloading skill: $SKILL_NAME"
echo ""

# Clone the repository (sparse checkout for efficiency)
cd "$TEMP_DIR"
git clone --depth 1 --filter=blob:none --sparse "$REPO_URL" skills-and-templates
cd skills-and-templates
git sparse-checkout set "$SKILL_NAME"

# Verify skill exists
if [ ! -d "$SKILL_NAME" ]; then
    echo "❌ Skill '$SKILL_NAME' not found in skills-and-templates repository"
    echo ""
    echo "Available skills:"
    ls -la | grep -E '^d' | awk '{print "  - " $NF}' | grep -v '^d' || echo "  (none found)"
    exit 1
fi

echo "✓ Downloaded $SKILL_NAME"
echo ""

# Read spec.yaml for installation instructions
if [ ! -f "$SKILL_DIR/spec.yaml" ]; then
    echo "⚠️  Warning: spec.yaml not found in skill"
fi

# Process skill based on its specification
echo "📦 Installing skill files..."
echo ""

# git-workflow-setup specific installation
if [ "$SKILL_NAME" = "git-workflow-setup" ]; then
    # Copy hooks
    if [ -d "$SKILL_DIR/hooks" ]; then
        mkdir -p "$PROJECT_ROOT/.githooks"
        cp "$SKILL_DIR/hooks"/* "$PROJECT_ROOT/.githooks/"
        chmod +x "$PROJECT_ROOT/.githooks"/*
        echo "✓ Installed git hooks to .githooks/"
    fi

    # Copy workflows
    if [ -d "$SKILL_DIR/workflows" ]; then
        mkdir -p "$PROJECT_ROOT/.github/workflows"
        cp "$SKILL_DIR/workflows"/* "$PROJECT_ROOT/.github/workflows/"
        echo "✓ Installed workflows to .github/workflows/"
    fi

    # Copy CLAUDE.md template
    if [ -f "$SKILL_DIR/templates/CLAUDE.md.template" ]; then
        TEMPLATE_FILE="$SKILL_DIR/templates/CLAUDE.md.template"
        if [ -f "$PROJECT_ROOT/CLAUDE.md" ]; then
            echo "ℹ️  CLAUDE.md already exists; review template manually:"
            echo "   $TEMPLATE_FILE"
        else
            cp "$TEMPLATE_FILE" "$PROJECT_ROOT/CLAUDE.md"
            echo "✓ Created CLAUDE.md from template"
        fi
    fi

    echo ""
    echo "🔧 Post-installation steps:"
    echo ""
    echo "1. Enable git hooks:"
    echo "   git config core.hooksPath .githooks"
    echo ""
    echo "2. Review and commit:"
    echo "   git add .githooks .github/workflows CLAUDE.md"
    echo "   git commit -m 'Add git workflow enforcement'"
    echo ""
    echo "3. Create a feature branch to test:"
    echo "   git checkout -b feature/test-workflow"
    echo ""
    echo "4. Try to commit to main (will be blocked):"
    echo "   git checkout main"
    echo "   echo 'test' > test.txt"
    echo "   git add test.txt"
    echo "   git commit -m 'Test' # Should fail"
    echo ""
    echo "✓ Skill '$SKILL_NAME' installed successfully"
else
    # Generic installation for other skills
    echo "Installing skill: $SKILL_NAME"
    echo "Refer to $SKILL_DIR/README.md for installation instructions"
fi

echo ""
echo "📚 For more information, see:"
echo "   $SKILL_DIR/README.md"
echo "   $SKILL_DIR/spec.yaml"
