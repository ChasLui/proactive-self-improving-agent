# AGENTS.md

本仓库是一个 agent skill 仓库，内容为 `proactive-self-improving-agent` 技能（自改进学习系统）。本文件是给在本仓库内工作的 agent（智能体）的约定。

## 仓库结构

| 路径 | 角色 |
|---|---|
| `.dsh/skills/proactive-self-improving-agent/SKILL.md` | **规范技能文件（唯一事实源）**。DSH 项目级发现位置（rank 100，`project-dsh` 源） |
| `SKILL.md` | 指向规范文件的符号链接，兼容 OpenClaw 与按 `<name>/SKILL.md` 目录包约定安装的加载器 |
| `.learnings/` | 运行时经验记录（LEARNINGS / ERRORS / FEATURE_REQUESTS / CHANGELOG），随技能使用而增长，不属于静态内容 |
| `README.md` | 安装与使用说明 |

**修改规则：**

1. 技能内容只编辑 `.dsh/skills/proactive-self-improving-agent/SKILL.md`，**不要编辑符号链接** `SKILL.md`（它是文件系统链接，不是可编辑副本）。
2. 不要直接改动 `.learnings/` 的模板头；运行时条目由技能自身按 CHANGELOG schema 追加。
3. 若移动/重命名规范文件，必须同步更新符号链接、README 与本节。

## Skill frontmatter 契约（DSH skill-filesystem）

- 文件首行必须是 `---`，frontmatter 为单个 YAML 对象，之后是 Markdown 正文。
- `name`：必填，kebab-case（`^[a-z0-9]+(?:-[a-z0-9]+)*$`）。
- `description`：必填非空字符串；DSH 模型目录只展示 `name` + `description`（默认截断 500 字符），因此 `description` 必须自含触发条件摘要，不能依赖 `whenToUse`（不进目录）。
- `whenToUse`：可选，额外路由提示。
- `disable-model-invocation` / `user-invocable`：可选，默认允许；只接受 YAML 布尔或 `true/false/yes/no/on/off/1/0`，非法值会使整个技能被丢弃。
- `version` / `author` 等额外键被 DSH 容忍，可保留。
- 发现仅一层：`<root>/<name>/SKILL.md` 或 `<root>/<name>.md`，不支持嵌套递归发现。

## 验收清单

- [ ] 只改了规范文件，符号链接未动
- [ ] frontmatter 的 `name` 为 kebab-case，`description` 非空且自含触发摘要（≤500 字符）
- [ ] 正文保持中文，结构与「快速参考」完整
- [ ] 有实质变更时递增 frontmatter `version`
- [ ] README 与本节的结构说明保持同步
