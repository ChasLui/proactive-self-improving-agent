# Proactive Self-Improving Agent

自动捕获经验 · 安全进化 · 记录轨迹

为 Kimi Code 设计的自改进技能，融合 proactive-agent 的行为准则与 self-improving-agent 的结构化学习系统。（上游为 OpenClaw 版本，本仓库已适配 Kimi Code 的技能与指令文件体系。）

## 特性

- **7 种触发条件**：错误、纠正、知识空白、更好做法、能力请求、任务完成回顾 + 学术场景扩展
- **结构化记录**：LEARNINGS / ERRORS / FEATURE_REQUESTS 三文件体系，按项目存放在 `.learnings/`
- **经验进化**：晋升机制（项目 `AGENTS.md` 或全局 `~/.kimi-code/AGENTS.md`）+ 递归检测（≥3 次自动晋升）+ 技能提取（`.agents/skills/`）
- **安全护栏**：ADL 防漂移 + VFM 价值优先评分
- **操作日志**：JSONL 格式 CHANGELOG，机器可读
- **行为准则**：坚韧不放弃、验证后报完成、安全加固

## 安装

将本仓库克隆到 Kimi Code 的技能扫描目录之一：

```bash
# 用户级（推荐）：所有项目可用，且与其他兼容 Agent Skills 的工具共享
git clone https://github.com/ChasLui/proactive-self-improving-agent.git ~/.agents/skills/proactive-self-improving-agent

# 或 Kimi Code 专属用户目录
git clone https://github.com/ChasLui/proactive-self-improving-agent.git ~/.kimi-code/skills/proactive-self-improving-agent

# 或项目级：仅单个项目可用，可随项目提交共享给团队
git clone https://github.com/ChasLui/proactive-self-improving-agent.git <your-project>/.agents/skills/proactive-self-improving-agent
```

重启会话后，Kimi Code 会按 `description` / `whenToUse` 自动触发，也可手动调用：

```
/skill:proactive-self-improving-agent
```

## 使用

技能触发后，所有经验记录存放在**当前项目根目录**的 `.learnings/`。首次在某个项目使用时初始化一次：

```bash
bash ~/.agents/skills/proactive-self-improving-agent/scripts/init-learnings.sh
```

生成：

```
.learnings/
├── LEARNINGS.md          # 经验/纠正/最佳实践/任务回顾
├── ERRORS.md             # 错误日志
├── FEATURE_REQUESTS.md   # 能力请求
└── CHANGELOG.md          # 操作日志（JSONL）
```

建议将 `.learnings/` 提交到项目 git 与团队共享；不需要则加入 `.gitignore`。

经验反复出现（≥3 次）或足够重要时，会按规则晋升：

- 项目级规则 → 项目根 `AGENTS.md`（Kimi Code 自动加载）
- 跨项目行为模式 → 全局 `~/.kimi-code/AGENTS.md`（或 `~/.agents/AGENTS.md`，跨工具通用）
- 可独立复用的方案 → 提取为 `.agents/skills/<name>/SKILL.md` 新技能

详见 [SKILL.md](SKILL.md)。

## 目录结构

```
├── SKILL.md                    # 技能本体（Kimi Code 格式 frontmatter）
├── scripts/
│   └── init-learnings.sh       # 在项目根目录初始化 .learnings/
└── templates/
    └── learnings/              # .learnings/ 的模板文件
```

## License

MIT
