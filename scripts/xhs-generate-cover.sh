#!/bin/bash
# xhs-generate-cover.sh — 为 DraftPush 生成封面 PNG
# 优先级：Agnes API → SenseNova API → Chrome 无头截图 → 跳过
# 用法: bash scripts/xhs-generate-cover.sh cover.html cover.png
set -euo pipefail

HTML_FILE="$1"
OUTPUT_PNG="${2:-cover.png}"

if [ ! -f "$HTML_FILE" ]; then
  echo "❌ 封面 HTML 不存在: $HTML_FILE" >&2
  exit 1
fi

# --- Priority 1 & 2: AI image generation ---
# 从 config/xhs.json 读取 image_api_keys
CONFIG_FILE="config/xhs.json"
if [ -f "$CONFIG_FILE" ]; then
  # 遍历 image_api_keys，按优先级尝试
  PROVIDERS=$(python3 -c "
import json
with open('$CONFIG_FILE') as f:
    config = json.load(f)
keys = config.get('image_api_keys', [])
for k in keys:
    provider = k.get('provider', '')
    key_field = k.get('key_field', '')
    api_key = config.get(key_field, '')
    if api_key:
        print(f'{provider}:{api_key}')
" 2>/dev/null || echo "")

  if [ -n "$PROVIDERS" ]; then
    while IFS=: read -r provider api_key; do
      echo "🎨 尝试 $provider 生成封面..." >&2
      case "$provider" in
        agnes)
          # Agnes API 调用（占位 — 实际由 AI agent 调用）
          echo "⚠️  Agnes API 需在 AI agent 中调用，脚本仅做 Chrome 截图回退" >&2
          ;;
        sensenova)
          echo "⚠️  SenseNova API 需在 AI agent 中调用，脚本仅做 Chrome 截图回退" >&2
          ;;
      esac
    done <<< "$PROVIDERS"
  fi
fi

# --- Priority 3: Chrome headless screenshot ---
CHROME=""
if command -v google-chrome &>/dev/null; then
  CHROME="google-chrome"
elif [ -f "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
  CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
fi

if [ -n "$CHROME" ] && [ -x "$CHROME" ]; then
  echo "📸 Chrome 无头截图: $HTML_FILE → $OUTPUT_PNG" >&2
  ABS_PATH=$(cd "$(dirname "$HTML_FILE")" && pwd)/$(basename "$HTML_FILE")
  "$CHROME" --headless=new --screenshot="$OUTPUT_PNG" \
    --window-size=1080,1440 --default-background-color=0 \
    "file://$ABS_PATH" 2>/dev/null

  if [ -f "$OUTPUT_PNG" ]; then
    echo "✅ 封面截图已生成: $OUTPUT_PNG ($(du -h "$OUTPUT_PNG" | cut -f1))" >&2
    exit 0
  fi
fi

# --- Priority 4: Skip ---
echo "⚠️  无法生成封面图片" >&2
echo "   Chrome 不可用，请手动截图 cover.html 保存为 cover.png" >&2
echo "   打开 $HTML_FILE → 截图 → 保存为 $OUTPUT_PNG" >&2
exit 0
