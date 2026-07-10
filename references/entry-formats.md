# 条目格式参考

按需加载。写入 `.learnings/` 前对照本文件确认字段。

## ID 规则

格式 `TYPE-YYYYMMDD-XXX`：

- `TYPE` ∈ `LRN`（经验）/ `ERR`（错误）/ `FEAT`（能力请求）
- `YYYYMMDD` 当天日期（用 `date +%Y%m%d` 取，不要凭记忆）
- `XXX` 三位序号，同日同类型递增

## 字段枚举

- `Status`: `pending` | `resolved` | `promoted` | `promoted_to_skill`
- `Priority`: `low` | `medium` | `high` | `critical`
- `Area`: `coding` | `tools` | `docs` | `config` | `workflow` | `research`
- `Pattern-Key`: **同一类问题必须复用同一个 key**（如 `chezmoi-readd`）。这是 ≥3 次晋升检测的唯一依据。
- `See Also`: 关联同 Pattern-Key 的旧条目 ID
- `Promoted-To`: 仅晋升后填，值为目标文件路径

复现次数不单独存字段，用 Pattern-Key 计数：

```bash
grep -rc "Pattern-Key: chezmoi-readd" ~/.claude/.learnings/
```

## Learning 条目

```markdown
## [LRN-YYYYMMDD-XXX] category

**Priority**: medium
**Status**: pending
**Area**: tools

### 内容
发生了什么、为什么错/不好、正确或更好的做法是什么。

### 建议修复
具体应该怎么改、改哪里。

### 元数据
- Source: error | correction | user_feedback | task_review | best_practice
- See Also: LRN-XXXXXXXX-XXX
- Pattern-Key: xxx
- Promoted-To: ~/.claude/CLAUDE.md（仅晋升后填写）

---
```

## Error 条目

```markdown
## [ERR-YYYYMMDD-XXX] 出错的工具/命令

**Priority**: high
**Status**: pending
**Area**: tools

### 摘要
什么操作失败了。

### 错误信息
（贴实际报错输出）

### 上下文
- 执行的命令 / 输入参数 / 环境信息

### 建议修复
可能的解决方案。

### 元数据
- Reproducible: yes | no | unknown
- See Also: ERR-XXXXXXXX-XXX
- Pattern-Key: xxx

---
```

## Feature Request 条目

```markdown
## [FEAT-YYYYMMDD-XXX] 能力名称

**Priority**: medium
**Status**: pending
**Area**: workflow

### 需要的能力
用户想做什么。

### 场景
为什么需要、解决什么问题。

### 复杂度
simple | medium | complex

### 建议实现
怎么做、可以扩展哪个现有功能。

### 元数据
- Frequency: first_time | recurring

---
```

## CHANGELOG.md

文件头是 markdown 说明，主体是一个 ` ```jsonl ` 代码块。每次写入 `.learnings/` 后在块内追加一行。

```jsonl
{"ts":"2026-07-09T21:30:00+08:00","action":"add","type":"learning","id":"LRN-20260709-001","summary":"≤100字"}
{"ts":"2026-07-10T09:00:00+08:00","action":"promote","type":"learning","id":"LRN-20260709-001","summary":"chezmoi re-add 规则","target":"~/.claude/CLAUDE.md"}
{"ts":"2026-07-11T10:00:00+08:00","action":"extract","type":"learning","id":"LRN-20260710-002","summary":"扫描版 PDF 处理流程","target":".claude/skills/pdf-fallback"}
{"ts":"2026-07-11T12:00:00+08:00","action":"resolve","type":"error","id":"ERR-20260709-001","summary":"改用 OCR fallback"}
```

| 字段 | 必填 | 说明 |
|---|---|---|
| `ts` | ✅ | ISO-8601，带时区。用 `date -Iseconds` 取 |
| `action` | ✅ | `add` / `promote` / `extract` / `resolve` |
| `type` | ✅ | `learning` / `error` / `feature` |
| `id` | ✅ | 对应条目 ID |
| `summary` | ✅ | ≤100 字 |
| `target` | ❌ | 仅 `promote` / `extract` 时填，目标路径 |

### 查询

```bash
CL=~/.claude/.learnings/CHANGELOG.md
extract() { sed -n '/^```jsonl$/,/^```$/p' "$CL" | grep -v '```'; }

extract | jq -c 'select(.action == "promote") | {id, summary, target}'
extract | jq -c 'select(.ts >= "2026-07-01" and .ts < "2026-08-01")'
extract | jq -s 'group_by(.action) | map({action: .[0].action, count: length})'
```
