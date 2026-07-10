<!--
# Proactive Self-Improving Agent (OpenCode Native)

This project provides a self-improvement skill for OpenCode AI agents.
It is installed as a global skill at `~/.config/opencode/skills/proactive-self-improving-agent/`.

## How It Works

The agent auto-detects 7 trigger scenarios (errors, corrections, knowledge gaps, etc.)
and records structured learnings into `.learnings/` directory for any project
where this skill is loaded.

## Usage

```opencode
skill(name="proactive-self-improving-agent")
```

## .learnings/ Directory Structure

```
.learnings/
├── LEARNINGS.md          # 经验/纠正/最佳实践/任务回顾
├── ERRORS.md             # 错误日志
├── FEATURE_REQUESTS.md   # 能力请求
└── CHANGELOG.md          # 操作日志（JSONL）
```

## Promotion Targets

| Experience Type | Promotes To |
|----------------|-------------|
| Workflow improvements | Project `AGENTS.md` or `opencode.json` instructions |
| Tool usage tips | Project-level instructions |
| Behavioral patterns | System instructions (AGENTS.md) |
| Generalizable skills | `~/.config/opencode/skills/<name>/` independent skill |
-->
