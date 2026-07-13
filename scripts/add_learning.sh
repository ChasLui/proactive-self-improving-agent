#!/bin/bash

# A script to add a new learning, error, or feature request
# to the .learnings directory.

set -e
set -o pipefail

# --- Argument parsing ---

type=""
category=""
area=""
priority=""
content=""
summary=""
status="pending"
source=""
see_also=""
pattern_key=""
reproducible="unknown"
frequency="first_time"
complexity="medium"

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --type) type="$2"; shift ;;
        --category) category="$2"; shift ;;
        --area) area="$2"; shift ;;
        --priority) priority="$2"; shift ;;
        --content) content="$2"; shift ;;
        --summary) summary="$2"; shift ;;
        --status) status="$2"; shift ;;
        --source) source="$2"; shift ;;
        --see-also) see_also="$2"; shift ;;
        --pattern-key) pattern_key="$2"; shift ;;
        --reproducible) reproducible="$2"; shift ;;
        --frequency) frequency="$2"; shift ;;
        --complexity) complexity="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# --- Validation ---

if [ -z "$type" ] || [ -z "$area" ] || [ -z "$priority" ] || [ -z "$content" ] || [ -z "$summary" ]; then
    echo "Usage: $0 --type <learning|error|feature_request> --area <area> --priority <priority> --content <content> --summary <summary> [other options]"
    exit 1
fi

case "$type" in
    learning|error|feature_request)
        ;;
    *)
        echo "Invalid type: $type. Must be one of 'learning', 'error', 'feature_request'."
        exit 1
        ;;
esac

echo "Type: $type"
echo "Area: $area"
echo "Priority: $priority"
echo "Content: $content"
echo "Summary: $summary"
echo "Status: $status"

# --- Logic ---

# 1. Generate ID
generate_id() {
    local type_prefix
    local target_file
    case "$type" in
        learning)
            type_prefix="LRN"
            target_file=".learnings/LEARNINGS.md"
            ;;
        error)
            type_prefix="ERR"
            target_file=".learnings/ERRORS.md"
            ;;
        feature_request)
            type_prefix="FEAT"
            target_file=".learnings/FEATURE_REQUESTS.md"
            ;;
    esac

    local date_str=$(date +%Y%m%d)
    local count=$(grep -c "\[$type_prefix-$date_str-" "$target_file" || true)
    local next_id=$(printf "%03d" $((count + 1)))
    
    echo "$type_prefix-$date_str-$next_id"
}

entry_id=$(generate_id)
echo "Generated ID: $entry_id"

# 2. Format content and append to file
format_and_append() {
    local entry_content
    local target_file

    case "$type" in
        learning)
            target_file=".learnings/LEARNINGS.md"
            entry_content=$(cat <<-EOF
## [$entry_id] $category

**Priority**: $priority
**Status**: $status
**Area**: $area

### 内容
$content

### 建议修复
(to be filled)

### 元数据
- Source: $source
- See Also: $see_also
- Pattern-Key: $pattern_key
- Promoted-To: 

---
EOF
)
            ;;
        error)
            target_file=".learnings/ERRORS.md"
            entry_content=$(cat <<-EOF
## [$entry_id] $summary

**Priority**: $priority
**Status**: $status
**Area**: $area

### 摘要
$summary

### 错误信息
\`\`\`
$content
\`\`\`

### 上下文
- 执行的命令/操作
- 输入参数
- 环境信息（如相关）

### 建议修复
(to be filled)

### 元数据
- Reproducible: $reproducible
- See Also: $see_also

---
EOF
)
            ;;
        feature_request)
            target_file=".learnings/FEATURE_REQUESTS.md"
            entry_content=$(cat <<-EOF
## [$entry_id] $summary

**Priority**: $priority
**Status**: $status
**Area**: $area

### 需要的能力
$content

### 场景
(to be filled)

### 复杂度
$complexity

### 建议实现
(to be filled)

### 元数据
- Frequency: $frequency

---
EOF
)
            ;;
    esac

    echo -e "\n$entry_content" >> "$target_file"
    echo "Appended new entry to $target_file"
}

format_and_append

# 3. Update changelog
update_changelog() {
    local changelog_file=".learnings/CHANGELOG.md"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local action="add"
    
    # Use a sed-friendly summary
    local safe_summary=$(echo "$summary" | sed 's/"/\\"/g')

    local changelog_entry="{\"ts\":\"$timestamp\",\"action\":\"$action\",\"type\":\"$type\",\"id\":\"$entry_id\",\"summary\":\"$safe_summary\"}"

    # Insert the new entry before the closing ``` of the jsonl block
    sed -i '' -e '$ d' "$changelog_file"
    echo "$changelog_entry" >> "$changelog_file"
    echo "\`\`\`" >> "$changelog_file"

    echo "Appended new entry to $changelog_file"
}

update_changelog

echo "Script executed successfully."

exit 0
