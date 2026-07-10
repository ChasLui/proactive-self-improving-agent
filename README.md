# Proactive Self-Improving Agent

自动捕获经验 · 安全进化 · 记录轨迹

面向 **Claude Code 原生 skill / plugin** 的自改进技能：让 agent 在日常工作中识别错误、纠正和最佳实践，结构化落盘，并在经验被反复验证后晋升为长期生效的规则。

## 特性

- **7 类触发**：命令失败、外部 API 出错、用户纠正、知识过时、更好做法、能力请求、任务完成回顾
- **去重优先**：触发 ≠ 必须写入。已有条目覆盖则跳过，避免污染检索
- **三文件经验池**：`LEARNINGS.md` / `ERRORS.md` / `FEATURE_REQUESTS.md`
- **单向晋升**：`.learnings/` → `CLAUDE.md` / `.claude/rules/` → `.claude/skills/`
- **安全护栏**：ADL 防漂移 + VFM 价值打分（≥30/50 才晋升）+ 改长期文件前必须告知用户
- **操作日志**：JSONL 格式 CHANGELOG，`jq` 可查

## 安装

作为 plugin（推荐，可随仓库更新）：

```
/plugin marketplace add ChasLui/proactive-self-improving-agent
/plugin install proactive-self-improving-agent@proactive-self-improving-agent
```

或作为个人 skill 手动安装：

```bash
git clone https://github.com/ChasLui/proactive-self-improving-agent.git \
  ~/.claude/skills/proactive-self-improving-agent
```

项目级安装把目标路径换成 `.claude/skills/proactive-self-improving-agent`（需接受 workspace trust）。

## 初始化经验池

首次使用时：

```bash
mkdir -p ~/.claude/.learnings
cp -n templates/learnings/*.md ~/.claude/.learnings/
```

Claude 也会在 skill 触发时自行完成这一步。

## 使用

安装后 Claude 会根据 `description` / `when_to_use` 自动加载，也可以手动调用：

```
/proactive-self-improving-agent
```

## 结构

```
.
├── SKILL.md                       # 主指令（原生 frontmatter）
├── references/
│   └── entry-formats.md           # 条目格式、ID 规则、CHANGELOG schema（按需加载）
├── templates/learnings/           # 经验池初始模板
└── .claude-plugin/
    ├── plugin.json                # plugin manifest
    └── marketplace.json           # 仓库即 marketplace
```

## 从 OpenClaw 版本迁移

| 项 | OpenClaw | Claude Code |
|---|---|---|
| frontmatter | `version` / `author` | 移入 `plugin.json` |
| 安装 | `openclaw add <repo>` | `/plugin marketplace add` |
| 经验池 | workspace `.learnings/` | `~/.claude/.learnings/`（项目特有经验可放 `./.claude/.learnings/`） |
| 晋升目标 | `AGENTS.md` / `TOOLS.md` / `SOUL.md` | `CLAUDE.md` / `.claude/rules/` |
| 技能提取 | `skills/<name>/` | `.claude/skills/<name>/SKILL.md` |
| VFM 门槛 | `< 50 不晋升`（满分即门槛，晋升永不触发） | `< 30 / 50 不晋升` |

## License

MIT
