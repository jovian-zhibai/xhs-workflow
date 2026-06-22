#!/bin/bash
# xhs-check-deps.sh — 一键检查所有 xhs-workflow 依赖是否安装
set -euo pipefail

echo "=== xhs-workflow 依赖检查 ==="
echo ""

HAS_ISSUE=0

# 检查 Wechatsync CLI
echo -n "Wechatsync CLI ............. "
if command -v wechatsync &>/dev/null; then
  echo "✅ 已安装 ($(wechatsync --version 2>&1 || echo 'version unknown'))"
else
  echo "❌ 未安装 → npm install -g @wechatsync/cli"
  HAS_ISSUE=1
fi

# 检查 anysearch skill
echo -n "anysearch skill ............ "
if [ -d "$HOME/.agents/skills/anysearch" ] || [ -d "./.agents/skills/anysearch" ]; then
  echo "✅ 已安装"
else
  echo "⚠️  未安装（推荐）→ npx skills add pinkpromise/anysearch"
  HAS_ISSUE=1
fi

# 检查 Obsidian vault
echo -n "Obsidian vault ............. "
if [ -f "config/xhs.json" ]; then
  VAULT=$(python3 -c "import json; print(json.load(open('config/xhs.json')).get('obsidian_vault_path',''))" 2>/dev/null || echo "")
  if [ -n "$VAULT" ] && [ -d "$VAULT" ]; then
    echo "✅ $VAULT"
  elif [ -n "$VAULT" ]; then
    echo "❌ 路径不存在: $VAULT"
    HAS_ISSUE=1
  else
    echo "⚠️  未配置"
  fi
else
  echo "⚠️  config/xhs.json 不存在 → cp config/xhs.example.json config/xhs.json"
  HAS_ISSUE=1
fi

# 检查配置文件
echo -n "config/xhs.json ............ "
if [ -f "config/xhs.json" ]; then
  echo "✅ 存在"
else
  echo "⚠️  不存在 → cp config/xhs.example.json config/xhs.json"
  HAS_ISSUE=1
fi

# 检查 pbcopy（手动复制方案）
echo -n "pbcopy（手动复制） ......... "
if command -v pbcopy &>/dev/null; then
  echo "✅ 可用"
else
  echo "⚠️  不可用（非 macOS 系统？）"
  HAS_ISSUE=1
fi

echo ""

if [ "$HAS_ISSUE" -eq 0 ]; then
  echo "🎉 所有依赖检查通过！"
else
  echo "⚠️  存在未安装或未配置的依赖，请根据上述提示修复。"
fi
