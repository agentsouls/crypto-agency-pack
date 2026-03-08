#!/bin/bash
# Crypto Agency Pack — Conversion Script
# Converts agent .md files into formats for supported tools
#
# Supported tools:
#   claude-code  — Claude Code agents (~/.claude/agents/)
#   cursor       — Cursor rules (.cursor/rules/)
#   aider        — Aider conventions (.aider.conf.yml)
#   windsurf     — Windsurf rules (.windsurf/rules/)
#   codex        — Codex agents (codex-agents/)
#   gemini       — Gemini CLI agents (.gemini/agents/)
#   opencode     — OpenCode agents (.opencode/agents/)
#   openclaw     — OpenClaw skills (~/.openclaw/workspace/skills/)
#
# Usage: ./scripts/convert.sh [tool]
# If no tool specified, converts for all supported tools.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$ROOT_DIR/crypto"
INTEGRATIONS_DIR="$ROOT_DIR/integrations"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

VALID_TOOLS=("claude-code" "cursor" "aider" "windsurf" "codex" "gemini" "opencode" "openclaw")

usage() {
    echo "Usage: $0 [tool]"
    echo ""
    echo "Supported tools: ${VALID_TOOLS[*]}"
    echo ""
    echo "If no tool is specified, converts for all supported tools."
    exit 1
}

# Extract YAML frontmatter value
get_frontmatter() {
    local file="$1"
    local key="$2"
    sed -n '/^---$/,/^---$/p' "$file" | grep "^${key}:" | sed "s/^${key}: *//"
}

# Extract body (everything after the second ---)
get_body() {
    local file="$1"
    awk 'BEGIN{n=0} /^---$/{n++; next} n>=2{print}' "$file"
}

# Convert to Claude Code agent format
convert_claude_code() {
    local outdir="$INTEGRATIONS_DIR/claude-code/agents"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local name=$(get_frontmatter "$file" "name")
        local desc=$(get_frontmatter "$file" "description")
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/${slug}.md"

        cat > "$outfile" << EOF
---
name: "$name"
description: "$desc"
---

$body
EOF
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to Cursor rules format
convert_cursor() {
    local outdir="$INTEGRATIONS_DIR/cursor/rules"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local name=$(get_frontmatter "$file" "name")
        local desc=$(get_frontmatter "$file" "description")
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/${slug}.mdc"

        cat > "$outfile" << EOF
---
description: $desc
globs:
alwaysApply: false
---

$body
EOF
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to Aider conventions format
convert_aider() {
    local outdir="$INTEGRATIONS_DIR/aider"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/CONVENTIONS-${slug}.md"

        echo "$body" > "$outfile"
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to Windsurf rules format
convert_windsurf() {
    local outdir="$INTEGRATIONS_DIR/windsurf/rules"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local name=$(get_frontmatter "$file" "name")
        local desc=$(get_frontmatter "$file" "description")
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/${slug}.md"

        cat > "$outfile" << EOF
---
trigger: manual
description: "$desc"
---

$body
EOF
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to Codex agents format
convert_codex() {
    local outdir="$INTEGRATIONS_DIR/codex/agents"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/${slug}.md"

        echo "$body" > "$outfile"
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to Gemini CLI agents format
convert_gemini() {
    local outdir="$INTEGRATIONS_DIR/gemini/agents"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/${slug}.md"

        echo "$body" > "$outfile"
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to OpenCode agents format
convert_opencode() {
    local outdir="$INTEGRATIONS_DIR/opencode/agents"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local outfile="$outdir/${slug}.md"

        echo "$body" > "$outfile"
        echo -e "  ${GREEN}✓${NC} $slug"
    done
}

# Convert to OpenClaw skill format
convert_openclaw() {
    local outdir="$INTEGRATIONS_DIR/openclaw/skills"
    mkdir -p "$outdir"

    for file in "$AGENTS_DIR"/*.md; do
        local name=$(get_frontmatter "$file" "name")
        local desc=$(get_frontmatter "$file" "description")
        local slug=$(basename "$file" .md | sed 's/^crypto-//')
        local body=$(get_body "$file")
        local skilldir="$outdir/crypto-${slug}"
        mkdir -p "$skilldir"
        local outfile="$skilldir/SKILL.md"

        cat > "$outfile" << EOF
---
name: "Crypto $name"
description: "$desc"
version: "1.0.0"
author: "AgentSouls"
---

# Instructions

$body
EOF
        echo -e "  ${GREEN}✓${NC} crypto-$slug"
    done
}

# Main
convert_tool() {
    local tool="$1"
    echo -e "${BLUE}Converting for: ${YELLOW}$tool${NC}"

    case "$tool" in
        claude-code) convert_claude_code ;;
        cursor)      convert_cursor ;;
        aider)       convert_aider ;;
        windsurf)    convert_windsurf ;;
        codex)       convert_codex ;;
        gemini)      convert_gemini ;;
        opencode)    convert_opencode ;;
        openclaw)    convert_openclaw ;;
        *)
            echo "Unknown tool: $tool"
            usage
            ;;
    esac

    echo ""
}

if [ $# -eq 0 ]; then
    echo -e "${BLUE}Converting crypto agents for all supported tools...${NC}"
    echo ""
    for tool in "${VALID_TOOLS[@]}"; do
        convert_tool "$tool"
    done
    echo -e "${GREEN}Done! Converted agents are in: $INTEGRATIONS_DIR/${NC}"
else
    for tool in "$@"; do
        convert_tool "$tool"
    done
fi
