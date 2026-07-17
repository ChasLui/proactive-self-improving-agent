#!/usr/bin/env bash
# init-learnings.sh — 在当前项目根目录初始化 .learnings/ 记录体系
# 用法: bash init-learnings.sh [项目根目录，默认当前目录]
set -euo pipefail

root="${1:-.}"
target="$root/.learnings"
template_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../templates/learnings" && pwd)"

if [ -d "$target" ]; then
  echo "已存在，跳过: $target"
  exit 0
fi

cp -R "$template_dir" "$target"
echo "已初始化 $target （LEARNINGS.md / ERRORS.md / FEATURE_REQUESTS.md / CHANGELOG.md）"
