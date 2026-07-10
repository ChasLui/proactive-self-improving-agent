# Proactive Self-Improving Agent

自动捕获经验 · 安全进化 · 记录轨迹

专为 omp (Oh My Pi) 设计的自改进技能，融合 proactive-agent 的行为准则与结构化学习系统。双模式运行：优先使用 omp 内置记忆工具（`retain` / `recall` / `reflect` / `learn` / `manage_skill`），无 memory backend 时自动回退到 `.learnings/` 文件系统。

## 特性

- **双模式架构**：omp 原生工具优先，文件系统自动回退
- **7 种触发条件**：错误、纠正、知识空白、更好做法、能力请求、任务完成回顾
- **omp 原生集成**：`retain` 记录 / `recall`+`reflect` 检索 / `learn`+`manage_skill` 进化
- **文件回退**：`.learnings/` 三文件体系 + JSONL CHANGELOG
- **安全护栏**：ADL 防漂移 + VFM 价值优先评分
- **行为准则**：坚韧不放弃、验证后报完成、安全加固

## 安装

### omp 原生安装

```bash
# 克隆到 omp 项目技能目录（项目级，最高优先级）
git clone https://github.com/ChasLui/proactive-self-improving-agent.git \
  .omp/skills/proactive-self-improving-agent

# 或安装为用户级技能
git clone https://github.com/ChasLui/proactive-self-improving-agent.git \
  ~/.omp/agent/skills/proactive-self-improving-agent

# 或使用 agents provider 路径
git clone https://github.com/ChasLui/proactive-self-improving-agent.git \
  .agent/skills/proactive-self-improving-agent
```

### 启用记忆后端（推荐）

在 `~/.omp/agent/config.yml` 或项目 `.omp/config.yml` 中：

```yaml
# 启用本地记忆（Mnemopi），自动持久化经验
memory:
  backend: mnemopi

# 启用 auto-learn，允许 agent 创建 managed skills
autolearn:
  enabled: true
```

不启用 memory backend 时，技能自动回退到 `.learnings/` 文件系统模式。

### 创建 fallback 目录（文件回退模式）

```bash
mkdir -p .learnings
```

## 使用

安装后 omp 自动发现并加载 `SKILL.md`（`alwaysApply: true`）。技能在后台运行，在以下时机自动触发：

- 命令执行失败时记录错误
- 被用户纠正时记录经验
- 任务完成时回顾并提取教训
- 同一问题反复出现时自动创建 managed skill

详见 [SKILL.md](SKILL.md)。

## 模式对比

| 能力 | omp 原生模式 | 文件回退模式 |
|---|---|---|
| 记录经验 | `retain` | `.learnings/LEARNINGS.md` |
| 记录错误 | `retain` | `.learnings/ERRORS.md` |
| 搜索历史 | `recall` / `reflect` | `grep .learnings/` |
| 创建技能 | `learn` / `manage_skill` | 手动编辑 + 复制 |
| 审计追溯 | 记忆后端自带时序 | JSONL CHANGELOG |
| 跨会话持久化 | ✅ 自动 | ✅ 文件持久 |

## License

MIT
