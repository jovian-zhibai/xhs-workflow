# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Claude Code skill for Xiaohongshu (小红书) content creation workflow. It covers the full lifecycle: 爆款拆解 (viral deconstruction) → 选题 (topic discovery) → 调研 (research) → 写文案 (writing) → 生成标签 (tag generation) → 封面设计 (cover design) → 打磨 (polishing) → 输出内容包 (output package) → 同步发布 (sync & publish) → 复盘 (review).

This is **not** a traditional codebase with build/test commands. It's a skill definition that instructs AI agents how to help users create and publish Xiaohongshu notes.

## Architecture

**SKILL.md** is the entry point. It defines:
- Frontmatter metadata (name, description, triggers, allowed-tools)
- Intent routing (9 routes based on user input type)
- Two execution modes: 全自动 (unattended) vs 半自动 (interactive with confirmation checkpoints)
- The 10-step workflow overview with pointers to reference docs
- Step status markers (`✅ 步骤 N：步骤名 — 结果`)
- De-AI-flavor checking (Humanizer + StopSlop or built-in 4-round scan)

**references/** contains detailed instructions for each workflow phase:
- `xhs-inspiration.md` — Topic discovery + viral deconstruction (3-mode scanning: 热点速报 / 深度选题 / 预判选题), connectivity cache for auto-adapting to network environment
- `xhs-research.md` — Research phase: competitor analysis, material collection, structured material packages
- `xhs-writing.md` — Writing phase: 6 content types, title formulas, emoji usage, word count (300-800)
- `xhs-tools.md` — Enhancement tools: title generator (6 strategies × 2 = 12 titles), tag recommender (pyramid strategy), note health report (5 dimensions), opening 3-line generator, cover design guide
- `xhs-publishing.md` — Publishing + review: Wechatsync auto-sync + manual copy fallback, data tracking (1h/24h/72h/7d), review report format
- `xhs-setup.md` — Setup assistant: 9-step guided configuration, auto-validation logic, config status report
- `chinese-copywriting-guidelines.md` — Chinese typography standards (pangu spacing, full-width punctuation, proper nouns)

**templates/** contains 5 cover HTML templates with inline styles:
- `minimal.html` — clean, white, high-end feel (tutorials, guides)
- `bold.html` — big text, impactful (种草, reviews, guides)
- `collage.html` — playful, multi-element (collections, fashion, food)
- `gradient.html` — soft, youthful (lifestyle, emotions, stories)
- `list.html` — numbered list, high information density (checklists, guides, tutorials)

All templates: 1080×1440px (3:4 ratio), inline styles only, placeholder support (`{{TITLE}}`, `{{SUBTITLE}}`, `{{CATEGORY}}`).

**scripts/** contains automation scripts:
- `xhs-check-deps.sh` — one-click dependency check (Wechatsync, anysearch, Obsidian vault)
- `xhs-sync.sh` — Wechatsync wrapper for syncing to Xiaohongshu drafts

## Key Constraints

- **One conversation, one note** — refuse if user tries to start a second note in the same conversation
- 半自动 mode pauses at key checkpoints: viral deconstruction confirmation, topic selection, outline review, draft review, title selection, cover confirmation, publish confirmation
- 全自动 mode never asks, auto-decides, skips failed steps and reports at the end
- Cover images use HTML inline styles, designed for browser screenshots
- Xiaohongshu has no official publish API — Wechatsync syncs to drafts, user publishes manually
- Tags use `#标签#` format (Xiaohongshu convention)
- Chinese typography follows chinese-copywriting-guidelines.md (spaces between Chinese/English, full-width punctuation, etc.)

## Configuration

```bash
cp config/xhs.example.json config/xhs.json  # then fill in your settings
```

Config file lookup order (first match wins):
1. `{current_project}/config/xhs.json` — user's project directory
2. `{skill_dir}/config/xhs.json` — skill installation directory

The config file contains secrets and is gitignored. Key fields:
- `author` — Xiaohongshu nickname
- `obsidian_vault_path` — Obsidian vault path for material library (optional)
- `default_style` — default content style (种草/测评/攻略/合集/教程/避雷)
- `wechatsync_platforms` — multi-platform sync target list
- `wechatsync_token` — Wechatsync API token (optional)
- `topic_sources` — user-configured topic sources by category
- `agnes_api_key` — Agnes AI API key for cover image generation (optional)
- `proxy` — proxy config object with `http` and `https` fields

## Dependencies

- **Required**: None — core writing/polishing works out of the box
- **Recommended**: anysearch skill (`npx skills add pinkpromise/anysearch`) — for viral deconstruction and topic discovery
- **Optional**: Wechatsync CLI (`npm install -g @wechatsync/cli`) + Chrome extension — for auto-sync to drafts
- **Optional**: Obsidian — for persistent material library
- **Optional**: Agnes AI API — for AI-generated cover images

## Modifying the Skill

When editing SKILL.md or reference files:
- Keep SKILL.md concise; detailed content goes in references/
- Follow the existing frontmatter format (name, description, allowed-tools)
- Reference files should be self-contained — the agent reads them independently
- Use imperative form, explain the "why" not just the "what"
