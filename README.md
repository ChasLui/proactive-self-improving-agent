# Proactive Self-Improving Agent for Grok

自动捕获经验 · 安全进化 · 记录轨迹

面向 **Grok Build / CLI** 的自改进技能：在日常工作中识别错误、纠正和最佳实践，结构化落盘到 `~/.grok/.learnings/`，验证后单向晋升到 `~/.grok/memory/` 或 `~/.grok/AGENTS.md`。

上游：OpenClaw 版 [claw-opus/proactive-self-improving-agent](https://github.com/claw-opus/proactive-self-improving-agent)  
同族分支：`claude` / `codex` / `grok`（本分支）

## 特性

- **6 类触发**：命令/工具/API/MCP 失败、用户纠正、知识过时、更好做法、能力请求、任务完成回顾
- **去重优先**：触发 ≠ 必须写入；先查 `memory/` 再查 `.learnings/`
- **双轨体系**：原始池 `.learnings/`（容忍噪音）→ 沉淀层 `memory/`（零噪音）
- **与原生 memory 互补**：不替代 `memory_search` / `/remember` / `/flush` / `/dream`
- **安全护栏**：ADL 防漂移 + VFM ≥30/50 才晋升 + 改长期文件前告知用户
- **操作日志**：JSONL CHANGELOG，`jq` 可查

## 安装

### 全局 skill（推荐）

```bash
mkdir -p ~/.grok/skills
git clone -b grok https://github.com/ChasLui/proactive-self-improving-agent.git \
  ~/.grok/skills/proactive-self-improving-agent
```

已有 clone 时：

```bash
# 确保在 grok 分支，再同步到技能目录
git checkout grok
rsync -a --delete \
  --exclude .git \
  ./ ~/.grok/skills/proactive-self-improving-agent/
```

> **用真实目录**，不要把本 skill 做成指向 `~/.agents/skills/proactive-self-improving-agent` 的 symlink——那边是 Codex 版，会互相覆盖。

项目级安装把目标换成仓库内 `.grok/skills/proactive-self-improving-agent`。

Grok 会扫描：

- `~/.grok/skills/`
- `./.grok/skills/`（以及向上到 repo root）
- 插件 skills、`[skills] paths` 额外路径

详见 [xAI Skills 文档](https://docs.x.ai/build/features/skills-plugins-marketplaces)。

### 初始化经验池

```bash
mkdir -p ~/.grok/.learnings
cp -n .learnings/*.md ~/.grok/.learnings/
```

## 使用

安装后按 `description` 自动匹配加载，也可手动：

```
/self-evolve
```

（frontmatter `name: self-evolve`，避免与 Codex 同名 skill 冲突。）

触发后 agent 会：评估是否有可复用新经验 → 去重 → 写入对应文件 → 追加 CHANGELOG；满足门槛时再晋升。

## 结构

```text
.
├── SKILL.md                 # 主协议（Grok 原生 frontmatter）
├── README.md
└── .learnings/              # 经验池初始模板（拷到 ~/.grok/.learnings/）
    ├── LEARNINGS.md
    ├── ERRORS.md
    ├── FEATURE_REQUESTS.md
    └── CHANGELOG.md
```

## 从 OpenClaw / 其他分支迁移

| 项 | OpenClaw (`main`) | Claude (`claude`) | Codex (`codex`) | **Grok（本分支）** |
|---|---|---|---|---|
| 安装 | `openclaw add` | plugin / `~/.claude/skills/` | `~/.codex/skills/` | `~/.grok/skills/` |
| skill name | `proactive-self-improving-agent` | 同左 | 同左 | **`self-evolve`** |
| 经验池 | workspace `.learnings/` | `~/.agents/.learnings/` | `~/.codex/.learnings/` | **`~/.grok/.learnings/`** |
| 晋升目标 | `AGENTS.md` / `TOOLS.md` / `SOUL.md` | `CLAUDE.md` / rules / skills | `AGENTS.md` / skills | **`memory/` / `AGENTS.md` / skills** |
| 沉淀检索 | — | 规则文件 grep | 规则文件 grep | **`memory_search` + `rg`** |
| VFM 门槛 | `< 50`（满分即门槛，几乎不可达） | `≥ 30 / 50` | 验证后晋升 | **`≥ 30 / 50`** |

## License

MIT
