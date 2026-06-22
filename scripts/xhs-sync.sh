#!/bin/bash
# xhs-sync.sh — 封装 Wechatsync 同步命令到小红书草稿箱
# 用法: bash scripts/xhs-sync.sh output/xxx.md "标题"
set -euo pipefail

FILE="$1"
TITLE="${2:-}"

if [ ! -f "$FILE" ]; then
  echo "❌ 文件不存在: $FILE" >&2
  exit 1
fi

# 如果没有提供标题，从文件第一行提取（去掉 # 前缀）
if [ -z "$TITLE" ]; then
  TITLE=$(head -1 "$FILE" | sed 's/^#\+\s*//')
fi

# 检查 Wechatsync 是否安装
if ! command -v wechatsync &>/dev/null; then
  echo "❌ Wechatsync CLI 未安装" >&2
  echo "   安装: npm install -g @wechatsync/cli" >&2
  echo "" >&2
  echo "💡 备用方案：手动复制" >&2
  echo "   pbcopy < $FILE" >&2
  echo "   然后打开小红书 APP 粘贴发布" >&2
  exit 1
fi

# 检查 token
TOKEN=""
if [ -f "config/xhs.json" ]; then
  TOKEN=$(python3 -c "import json; print(json.load(open('config/xhs.json')).get('wechatsync_token',''))" 2>/dev/null || echo "")
fi

if [ -z "$TOKEN" ]; then
  echo "⚠️  未配置 wechatsync_token，尝试使用已有认证..." >&2
else
  export WECHATSYNC_TOKEN="$TOKEN"
fi

echo "🚀 同步到小红书草稿箱..." >&2
echo "   文件: $FILE" >&2
echo "   标题: $TITLE" >&2
echo "" >&2

wechatsync sync "$FILE" -p xiaohongshu -t "$TITLE"

echo "" >&2
echo "✅ 已同步到草稿箱，请在 APP 中检查排版后发布" >&2
echo "💡 黄金发布时间：7-9点、12-14点、19-21点" >&2
