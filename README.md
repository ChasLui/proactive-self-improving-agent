# Proactive Self-Improving Agent for Codex

Codex skill for recording reusable lessons from failures, user corrections, stale assumptions, missing capabilities, and end-of-task retrospectives.

The goal is lightweight self-improvement: keep raw learning records in local files, deduplicate before writing, and promote only small verified rules into Codex configuration or skills.

## What It Does

- Records reusable learnings in `~/.codex/.learnings/LEARNINGS.md`
- Records reusable failures in `~/.codex/.learnings/ERRORS.md`
- Records missing reusable capabilities in `~/.codex/.learnings/FEATURE_REQUESTS.md`
- Appends machine-readable audit rows to `~/.codex/.learnings/CHANGELOG.md`
- Requires deduplication before writing new entries
- Promotes lessons only when they are verified, reusable, and small enough to keep long-term instructions useful

## Install

Clone or copy this repository into Codex's native skills directory:

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/ChasLui/proactive-self-improving-agent.git ~/.codex/skills/proactive-self-improving-agent
```

If you already manage skills elsewhere, the required runtime file is:

```text
~/.codex/skills/proactive-self-improving-agent/SKILL.md
```

## Initialize Learnings

Create the Codex learning store:

```bash
mkdir -p ~/.codex/.learnings
cp .learnings/*.md ~/.codex/.learnings/
```

If `~/.codex` is managed by chezmoi, keep the source copy in sync, for example under:

```text
~/.local/share/chezmoi/dot_codex/dot_learnings/
```

## Usage

When this skill is loaded, Codex should evaluate whether a new reusable lesson exists after:

- command, tool, API, MCP, browser, or filesystem failures
- user corrections such as "不对", "不是", "错了", or "应该是"
- stale assumptions or outdated API knowledge
- discovery of a better repeatable workflow
- requests for missing reusable Codex capabilities
- task completion retrospectives

Not every trigger should create a record. Skip one-off noise, ordinary task logs, secrets, and anything already covered by an existing entry.

See [SKILL.md](SKILL.md) for the full protocol.

## Files

```text
.
├── SKILL.md
├── README.md
└── .learnings/
    ├── LEARNINGS.md
    ├── ERRORS.md
    ├── FEATURE_REQUESTS.md
    └── CHANGELOG.md
```

## License

MIT
