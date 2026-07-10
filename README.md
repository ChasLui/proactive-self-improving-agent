# Proactive Self-Improving Agent

自动捕获经验 · 安全进化 · 记录轨迹

专为 OpenCode AI agent 设计的自改进技能，融合 proactive-agent 的行为准则与 self-improving-agent 的结构化学习系统。

## 特性

- **7 种触发条件**：错误、纠正、知识空白、更好做法、能力请求、任务完成回顾 + 学术场景扩展
- **结构化记录**：LEARNINGS / ERRORS / FEATURE_REQUESTS 三文件体系
- **经验进化**：晋升机制 + 递归检测（≥3 次自动晋升）+ 技能提取
- **安全护栏**：ADL 防漂移 + VFM 价值优先评分
- **操作日志**：JSONL 格式 CHANGELOG，机器可读
- **行为准则**：坚韧不放弃、验证后报完成、安全加固

## 安装

```bash
# OpenCode — 全局 skill 安装（symlink 到 skills 目录）
ln -sf /Users/chao.liu/my-clone/github.com/ChasLui/proactive-self-improving-agent ~/.config/opencode/skills/proactive-self-improving-agent

# 在任何项目中使用 skill 加载：
# skill(name="proactive-self-improving-agent")
```

## 使用

加载后 agent 自动应用 SKILL.md 规则。`.learnings/` 目录会在 skill 加载的项目中自动创建和使用。

```bash
mkdir -p .learnings
```

详见 [SKILL.md](SKILL.md)。

## License

MIT
