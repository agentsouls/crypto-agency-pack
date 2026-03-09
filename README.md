# 🏦 Crypto Agency Pack

**13 specialized AI agents for crypto research, trading, DeFi, and security** — built for the tools you already use.

Works with: **Claude Code** · **Cursor** · **Windsurf** · **Aider** · **Codex** · **Gemini CLI** · **OpenCode** · **OpenClaw**

Inspired by [agency-agents](https://github.com/msitarzewski/agency-agents) — the crypto division they didn't build.

---

## 🎯 Why This Exists

Generic AI agents don't understand on-chain data, tokenomics, MEV, or DeFi yield decomposition. These agents do. Each one is a domain specialist with structured deliverable templates, clear workflows, and the kind of precision that prevents expensive mistakes in crypto.

## 📋 The Agents

| Agent | What It Does |
|---|---|
| **On-Chain Analyst** | Wallet tracking, transaction flow analysis, protocol metrics, smart money identification |
| **DeFi Yield Optimizer** | Yield farming strategy, risk-adjusted APY decomposition, IL modeling, position management |
| **Whale Tracker** | Large-wallet monitoring, accumulation/distribution detection, exchange flow analysis |
| **Sentiment Scanner** | Multi-signal composite scoring: Fear & Greed, funding rates, OI, options skew, social volume |
| **Tokenomics Analyst** | Supply schedule analysis, vesting unlock modeling, value accrual evaluation, incentive alignment |
| **Smart Contract Auditor** | Vulnerability identification, exploit path modeling, security checklist, Solidity/Vyper review |
| **Web3 Developer** | Production Solidity, gas optimization, dApp frontend, Hardhat/Foundry testing |
| **Crypto Trader** | Market structure analysis, trade setup framework, position sizing, risk management |
| **MEV Researcher** | Arbitrage modeling, sandwich analysis, flashloan mechanics, builder economics |
| **Governance Analyst** | Proposal evaluation, voting power distribution, DAO health assessment, governance attacks |
| **Staking Optimizer** | PoS yield strategy, liquid staking comparison, restaking risk, validator selection |
| **Airdrop Hunter** | Protocol targeting, interaction strategy, Sybil-safe farming, expected value analysis |
| **Regulatory Analyst** | Global framework tracking, enforcement patterns, compliance impact, jurisdiction comparison |
| **NFT Appraiser** | Collection fundamentals, rarity valuation, wash trading detection, portfolio management |

## ⚡ Quick Install

### Option 1: Auto-Detect (Recommended)

```bash
git clone https://github.com/agentsouls/crypto-agency-pack.git
cd crypto-agency-pack
./scripts/install.sh
```

The installer auto-detects which tools you have and installs agents in the right format for each one.

### Option 2: Specific Tool

```bash
./scripts/install.sh claude-code    # Claude Code only
./scripts/install.sh cursor         # Cursor only
./scripts/install.sh openclaw       # OpenClaw only
./scripts/install.sh windsurf       # Windsurf only
```

### Option 3: Convert Only (Don't Install)

```bash
./scripts/convert.sh               # Convert for all tools
./scripts/convert.sh openclaw      # Convert for specific tool
```

Converted files appear in `integrations/<tool>/`.

## 🔧 How It Works

Each agent is a single `.md` file in `crypto/` with YAML frontmatter:

```yaml
---
name: On-Chain Analyst
description: Expert blockchain data analyst...
color: blue
---

# On-Chain Analyst Agent Personality

You are **On-Chain Analyst**, ...
```

The conversion script transforms these into the native format for each tool:

| Tool | Format | Install Location |
|---|---|---|
| Claude Code | `.md` agent files | `~/.claude/agents/` |
| Cursor | `.mdc` rule files | `.cursor/rules/` |
| Aider | `CONVENTIONS-*.md` | Project root |
| Windsurf | `.md` rule files | `.windsurf/rules/` |
| Codex | `.md` agent files | `codex-agents/` |
| Gemini CLI | `.md` agent files | `~/.gemini/agents/` |
| OpenCode | `.md` agent files | `~/.opencode/agents/` |
| OpenClaw | `SKILL.md` skills | `~/.openclaw/workspace/skills/` |

## 📖 Usage Examples

### Claude Code
```
claude
> /agents
> Select: On-Chain Analyst
> "Analyze the top 10 holders of $TOKEN and identify any accumulation patterns"
```

### Cursor
Open any crypto project — the agents appear as available rules. Reference them in chat:
```
@onchain-analyst Trace the funding source for wallet 0x...abc
```

### OpenClaw
Agents appear as skills in your workspace. Use naturally:
```
"Use the whale tracker to check BTC exchange flows for the last 7 days"
```

## 🏗 Agent Quality

Every agent includes:

- **Structured deliverable templates** — copy-paste ready output formats for reports, evaluations, and scorecards
- **Workflow processes** — step-by-step methodology, not just vibes
- **Critical rules** — hard constraints that prevent dangerous mistakes (e.g., "never give false confidence on a contract audit")
- **Communication style** — precise, numbers-first, uncertainty-aware
- **Success metrics** — how to evaluate if the agent is actually performing

## 🤝 Contributing

Want to add a crypto agent? Follow the format in `crypto/`:

1. Create `crypto/crypto-your-agent-name.md`
2. Include YAML frontmatter: `name`, `description`, `color`
3. Follow the section structure: Identity, Core Mission, Critical Rules, Deliverables, Workflow, Communication Style, Success Metrics
4. Run `./scripts/convert.sh` to generate integrations
5. Submit a PR

## 💰 Support

If these agents save you time or money, consider supporting the project:

**USDC (Solana):** `GyPhG2mBWuWGBHou9cPfDdoPMnuPYcM9QhmY4VP26ggv`

## 📄 License

MIT — use these agents however you want. Attribution appreciated but not required.

---

Built by [AgentSouls](https://agentsouls.xyz) — AI agents that actually know crypto.
