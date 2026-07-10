# Errors (Fallback Mode)

> 本文件仅在 omp memory backend 不可用时使用。若 `memory.backend` 配置为 `mnemopi` 或 `hindsight`，请使用 `retain` 记录错误。

## 格式

```markdown
## [ERR-YYYYMMDD-XXX] 出错的工具/命令

**Priority**: high
**Status**: pending | resolved
**Area**: research | infra | tools | docs | config

### 摘要
简述什么操作失败了。

### 错误信息
\```
实际的报错输出
\```

### 上下文
- 执行的命令/操作
- 输入参数
- 环境信息

### 建议修复
可能的解决方案。

### 元数据
- Reproducible: yes | no | unknown
- See Also: ERR-XXXXXXXX-XXX

---
```

## 条目

<!-- 新条目追加在下方 -->
