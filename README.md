# Proactive Self-Improving Agent

自动捕获经验 · 安全进化 · 记录轨迹

面向 **reasonix 原生 skill** 的自改进技能：让 agent 在日常工作中识别错误、纠正和最佳实践，结构化落盘，并在经验被反复验证后晋升为长期生效的规则。

## 特性

- **7 类触发**：命令失败、外部 API 出错、用户纠正、知识过时、更好做法、能力请求、任务完成回顾
- **去重优先**：触发 ≠ 必须写入。memory 沉淀层或已有条目覆盖则跳过，避免污染检索
- **三文件经验池**：`~/.agents/.learnings/` 下 `LEARNINGS.md` / `ERRORS.md` / `FEATURE_REQUESTS.md`
- **单向晋升**：`.learnings/` 原始池 → memory 沉淀层 → `CLAUDE.md` / `AGENT-SKILLS.md` → 独立 skill
- **安全护栏**：ADL 防漂移 + VFM 价值打分（≥30/50 才晋升）+ 改长期生效文件前必须告知用户
- **操作日志**：JSONL 格式 CHANGELOG，`jq` 可查

## 安装

全局安装（推荐，所有项目生效）：

```bash
git clone https://github.com/ChasLui/proactive-self-improving-agent.git \
  ~/.claude/skills/proactive-self-improving-agent
```

项目级安装（仅当前项目生效）：

```bash
git clone https://github.com/ChasLui/proactive-self-improving-agent.git \
  .reasonix/skills/proactive-self-improving-agent
```

也可以用 `install_skill` 工具从本仓库导入。

## 初始化经验池

首次使用时：

```bash
mkdir -p ~/.agents/.learnings
cp -n templates/learnings/*.md ~/.agents/.learnings/
```

reasonix 也会在 skill 触发时自行完成这一步。

## 使用

安装后 reasonix 根据 `description` 自动加载 skill，也可以手动调用：

```text
/proactive-self-improving-agent
```

## 结构

```text
.
├── SKILL.md                       # 主指令（reasonix 原生 frontmatter）
├── references/
│   └── entry-formats.md           # 条目格式、ID 规则、CHANGELOG schema（按需加载）
├── templates/learnings/           # 经验池初始模板
└── .learnings/                    # 项目级经验池示例（与用户级结构相同）
```

## 从 OpenClaw 版本迁移

| 项 | OpenClaw | reasonix |
|---|---|---|
| frontmatter | `version` / `author` | `name` / `description`（触发条件内嵌 description） |
| 安装 | `openclaw add <repo>` | clone 到 `~/.claude/skills/` 或 `.reasonix/skills/` |
| 经验池 | workspace `.learnings/` | `~/.agents/.learnings/`（项目特有经验可放 `<repo>/.learnings/`） |
| 写入前置去重 | 仅查 `.learnings/` | 先查 memory 沉淀层，再查 `.learnings/` |
| 晋升目标 | `AGENTS.md` / `TOOLS.md` / `SOUL.md` | memory 沉淀层 / `CLAUDE.md` / `AGENT-SKILLS.md` |
| 技能提取 | `skills/<name>/` | `~/.claude/skills/<name>/` 或 `.reasonix/skills/<name>/` |
| VFM 门槛 | `< 50 不晋升`（满分即门槛，晋升永不触发） | `< 30 / 50 不晋升` |

## License

MIT
