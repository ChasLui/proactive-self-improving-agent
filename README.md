# Proactive Self-Improving Agent

自动捕获经验 · 安全进化 · 记录轨迹

专为 agent 设计的自改进技能，融合 proactive-agent 的行为准则与 self-improving-agent 的结构化学习系统。原生支持 [DeepSeek Harness (DSH)](https://github.com/deepseek-ai/deepseek-harness) 技能发现，同时兼容 OpenClaw。

## 特性

- **7 种触发条件**：错误、纠正、知识空白、更好做法、能力请求、任务完成回顾 + 学术场景扩展
- **结构化记录**：LEARNINGS / ERRORS / FEATURE_REQUESTS 三文件体系
- **经验进化**：晋升机制 + 递归检测（≥3 次自动晋升）+ 技能提取
- **安全护栏**：ADL 防漂移 + VFM 价值优先评分
- **操作日志**：JSONL 格式 CHANGELOG，机器可读
- **行为准则**：坚韧不放弃、验证后报完成、安全加固
- **DSH 原生支持**：`.dsh/skills/` 目录包格式，frontmatter 符合 DSH skill-filesystem 解析契约

## 仓库结构

```
proactive-self-improving-agent/
├── .dsh/skills/proactive-self-improving-agent/SKILL.md  # 规范技能文件（唯一事实源）
├── SKILL.md                                             # 符号链接 → 规范文件（兼容 OpenClaw 等加载器）
├── .learnings/                                          # 运行时经验记录（LEARNINGS/ERRORS/FEATURE_REQUESTS/CHANGELOG）
└── README.md
```

技能正文的**唯一事实源**是 `.dsh/skills/proactive-self-improving-agent/SKILL.md`；仓库根目录的 `SKILL.md` 是指向它的符号链接，供 OpenClaw 及按 `<name>/SKILL.md` 目录包约定安装的加载器读取。修改技能时只编辑规范文件。

## 安装

### 方式一：DSH 用户级安装（推荐）

DSH 会扫描用户技能目录 `~/.dsh/skills`（rank 400）与 `~/.agents/skills`（rank 500），目录包格式为 `<name>/SKILL.md`：

```bash
git clone https://github.com/ChasLui/proactive-self-improving-agent.git ~/.dsh/skills/proactive-self-improving-agent
# 或
git clone https://github.com/ChasLui/proactive-self-improving-agent.git ~/.agents/skills/proactive-self-improving-agent
```

### 方式二：DSH 项目级安装

DSH 以最近含 `.git` 的目录为项目根，扫描 `<项目根>/.dsh/skills`（rank 100，优先）与 `<项目根>/.agents/skills`（rank 200）。把本仓库克隆为项目，或把其中的 `.dsh/skills/` 目录复制到目标项目根即可：

```bash
git clone https://github.com/ChasLui/proactive-self-improving-agent.git my-project
# DSH 在 my-project 下运行时会自动发现 proactive-self-improving-agent
```

### 方式三：OpenClaw

```bash
openclaw add https://github.com/ChasLui/proactive-self-improving-agent

# 或手动
git clone https://github.com/ChasLui/proactive-self-improving-agent.git ~/.openclaw/skills/proactive-self-improving-agent
```

## 使用

安装后 agent 自动加载 SKILL.md。确保 workspace 下有 `.learnings/` 目录：

```bash
mkdir -p .learnings
```

详见 [SKILL.md](SKILL.md)。

## DSH 兼容性说明

技能 frontmatter 遵循 DSH `skill-filesystem` 提供方的解析契约：

| 字段 | 说明 |
|---|---|
| `name` | 必填，kebab-case（`^[a-z0-9]+(?:-[a-z0-9]+)*$`） |
| `description` | 必填；模型目录只展示 name + description（默认截断 500 字符），因此必须自含触发条件摘要 |
| `whenToUse` | 可选，额外路由提示 |
| `disable-model-invocation` / `user-invocable` | 可选，默认允许模型/用户调用；非法值会丢弃整个技能 |
| `version` / `author` | 兼容保留，DSH 容忍额外键 |

DSH 本地发现只扫描一层：`<root>/<name>/SKILL.md`（目录包）或 `<root>/<name>.md`（扁平文件），不支持嵌套。任何技能变更（frontmatter 或正文）都会被 watcher 或下一次读取捕获，无需重启。

## License

MIT
