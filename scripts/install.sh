#!/bin/bash
# Crypto Agency Pack — Install Script
# Auto-detects installed tools and installs crypto agents to the correct locations
#
# Usage: ./scripts/install.sh [tool]
# If no tool specified, auto-detects and installs for all found tools.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
INTEGRATIONS_DIR="$ROOT_DIR/integrations"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

detected_tools=()

# First, ensure conversions exist
ensure_converted() {
    if [ ! -d "$INTEGRATIONS_DIR/claude-code" ] && [ ! -d "$INTEGRATIONS_DIR/openclaw" ]; then
        echo -e "${YELLOW}Running conversion first...${NC}"
        bash "$ROOT_DIR/scripts/convert.sh"
        echo ""
    fi
}

# Detection functions
detect_claude_code() {
    if command -v claude &>/dev/null || [ -d "$HOME/.claude" ]; then
        detected_tools+=("claude-code")
        return 0
    fi
    return 1
}

detect_cursor() {
    if [ -d "$HOME/.cursor" ] || [ -d "$HOME/Library/Application Support/Cursor" ] || command -v cursor &>/dev/null; then
        detected_tools+=("cursor")
        return 0
    fi
    return 1
}

detect_aider() {
    if command -v aider &>/dev/null; then
        detected_tools+=("aider")
        return 0
    fi
    return 1
}

detect_windsurf() {
    if [ -d "$HOME/.windsurf" ] || [ -d "$HOME/Library/Application Support/Windsurf" ] || command -v windsurf &>/dev/null; then
        detected_tools+=("windsurf")
        return 0
    fi
    return 1
}

detect_codex() {
    if command -v codex &>/dev/null; then
        detected_tools+=("codex")
        return 0
    fi
    return 1
}

detect_gemini() {
    if command -v gemini &>/dev/null || [ -d "$HOME/.gemini" ]; then
        detected_tools+=("gemini")
        return 0
    fi
    return 1
}

detect_opencode() {
    if command -v opencode &>/dev/null || [ -d "$HOME/.opencode" ]; then
        detected_tools+=("opencode")
        return 0
    fi
    return 1
}

detect_openclaw() {
    if command -v openclaw &>/dev/null || [ -d "$HOME/.openclaw" ]; then
        detected_tools+=("openclaw")
        return 0
    fi
    return 1
}

# Install functions
install_claude_code() {
    local src="$INTEGRATIONS_DIR/claude-code/agents"
    local dest="$HOME/.claude/agents"
    mkdir -p "$dest"

    local count=0
    for file in "$src"/*.md; do
        cp "$file" "$dest/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count agents to $dest"
}

install_cursor() {
    local src="$INTEGRATIONS_DIR/cursor/rules"
    local dest=".cursor/rules"
    mkdir -p "$dest"

    local count=0
    for file in "$src"/*.mdc; do
        cp "$file" "$dest/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count rules to $dest (project-level)"
}

install_aider() {
    local src="$INTEGRATIONS_DIR/aider"
    local count=0
    for file in "$src"/CONVENTIONS-*.md; do
        cp "$file" "./"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count conventions to current directory"
}

install_windsurf() {
    local src="$INTEGRATIONS_DIR/windsurf/rules"
    local dest=".windsurf/rules"
    mkdir -p "$dest"

    local count=0
    for file in "$src"/*.md; do
        cp "$file" "$dest/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count rules to $dest"
}

install_codex() {
    local src="$INTEGRATIONS_DIR/codex/agents"
    local dest="codex-agents"
    mkdir -p "$dest"

    local count=0
    for file in "$src"/*.md; do
        cp "$file" "$dest/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count agents to $dest"
}

install_gemini() {
    local src="$INTEGRATIONS_DIR/gemini/agents"
    local dest="$HOME/.gemini/agents"
    mkdir -p "$dest"

    local count=0
    for file in "$src"/*.md; do
        cp "$file" "$dest/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count agents to $dest"
}

install_opencode() {
    local src="$INTEGRATIONS_DIR/opencode/agents"
    local dest="$HOME/.opencode/agents"
    mkdir -p "$dest"

    local count=0
    for file in "$src"/*.md; do
        cp "$file" "$dest/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count agents to $dest"
}

install_openclaw() {
    local src="$INTEGRATIONS_DIR/openclaw/skills"
    local dest="$HOME/.openclaw/workspace/skills"
    mkdir -p "$dest"

    local count=0
    for skilldir in "$src"/crypto-*; do
        local skillname=$(basename "$skilldir")
        mkdir -p "$dest/$skillname"
        cp "$skilldir/SKILL.md" "$dest/$skillname/"
        count=$((count + 1))
    done
    echo -e "  ${GREEN}✓${NC} Installed $count skills to $dest"
}

# Install for a specific tool
install_tool() {
    local tool="$1"
    echo -e "${BLUE}Installing for: ${YELLOW}$tool${NC}"

    case "$tool" in
        claude-code) install_claude_code ;;
        cursor)      install_cursor ;;
        aider)       install_aider ;;
        windsurf)    install_windsurf ;;
        codex)       install_codex ;;
        gemini)      install_gemini ;;
        opencode)    install_opencode ;;
        openclaw)    install_openclaw ;;
        *)
            echo -e "${RED}Unknown tool: $tool${NC}"
            exit 1
            ;;
    esac
}

# Main
echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Crypto Agency Pack — Installer      ║${NC}"
echo -e "${BLUE}║   13 crypto-native AI agents          ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""

ensure_converted

if [ $# -gt 0 ]; then
    # Install for specified tools
    for tool in "$@"; do
        install_tool "$tool"
    done
else
    # Auto-detect
    echo -e "${BLUE}Detecting installed tools...${NC}"

    detect_claude_code || true
    detect_cursor || true
    detect_aider || true
    detect_windsurf || true
    detect_codex || true
    detect_gemini || true
    detect_opencode || true
    detect_openclaw || true

    echo ""

    if [ ${#detected_tools[@]} -eq 0 ]; then
        echo -e "${RED}No supported tools detected.${NC}"
        echo ""
        echo "Supported tools: claude-code, cursor, aider, windsurf, codex, gemini, opencode, openclaw"
        echo "Install one of these tools, or run: $0 <tool-name>"
        exit 1
    fi

    echo -e "${GREEN}Found ${#detected_tools[@]} tool(s):${NC} ${detected_tools[*]}"
    echo ""

    for tool in "${detected_tools[@]}"; do
        install_tool "$tool"
        echo ""
    done
fi

echo -e "${GREEN}Done! Your crypto agents are ready.${NC}"
echo ""
echo "Quick start:"
echo "  Claude Code: claude — then use /agents to select a crypto agent"
echo "  Cursor:      open a project — agents available in rules"
echo "  OpenClaw:    agents appear as skills in your workspace"
echo ""
echo "Full docs: https://agentsouls.xyz/crypto-agency-pack"
