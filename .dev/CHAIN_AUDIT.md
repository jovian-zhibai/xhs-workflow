# xhs-workflow 全链路审计报告

> 审计日期：2025-06-22
> 审计范围：SKILL.md 声称的 10 步流程 vs references/ 实际内容

---

## 审计总结

| 步骤 | 名称 | 文档状态 | 可执行性 | 备注 |
|------|------|---------|---------|------|
| 1 | 爆款拆解 | ✅ 完整 | ⚠️ 部分缺失 | anysearch 安装说明不足 |
| 2 | 选题 | ✅ 完整 | ✅ 可跑通 | 依赖 anysearch/WebSearch |
| 3 | 调研 | ✅ 完整 | ✅ 可跑通 | 搜索模板完整 |
| 4 | 写文案 | ✅ 完整 | ✅ 可跑通 | 风格指南完整 |
| 5 | 生成标签 | ✅ 完整 | ✅ 可跑通 | 金字塔搭配清晰 |
| 6 | 封面设计 | ✅ 完整 | ⚠️ 待验证 | 5 个模板需要渲染验证 |
| 7 | 打磨 | ✅ 完整 | ✅ 可跑通 | 去AI味+5维度体检 |
| 8 | 输出内容包 | ✅ 完整 | ✅ 可跑通 | 格式定义清晰 |
| 9 | 同步发布 | ✅ 完整 | ⚠️ 部分缺失 | Wechatsync 依赖外部工具 |
| 10 | 复盘 | ✅ 完整 | ✅ 可跑通 | 数据模板完整 |

---

## 逐步骤详细审计

### 步骤 1：爆款拆解
- **文档**：`references/xhs-inspiration.md` ✅
- **SKILL.md 引用**：正确指向 `references/xhs-inspiration.md` ✅
- **依赖**：anysearch skill
  - ⚠️ README 只说 "anysearch skill（已安装）"，未说明如何安装
  - ⚠️ SKILL.md 中提到 "用 anysearch 搜索"，但未在 README 前置条件中说明安装方式
- **筛选标准**（点赞+收藏 > 1000）：纯文档描述，无代码实现 ✅ （合理，AI 执行时判断）
- **信源 URL**：依赖 anysearch 搜索，无硬编码 URL ✅ （灵活，不会过期）
- **Obsidian 保存路径**：`{vault}/12-小红书/素材库/` — 路径模板清晰 ✅

### 步骤 2：选题
- **文档**：`references/xhs-inspiration.md` ✅
- **三模式扫描**：热点速报/深度选题/预判选题 — 文档完整 ✅
- **信源列表**：小红书热搜、微博热搜、抖音热榜、Pinterest、Instagram、豆瓣、知乎 ✅
- **选题输出格式**：标题+来源+爆款潜力+理由 ✅
- ⚠️ 信源连通性缓存机制（`config/connectivity.json`）设计好但未在 SKILL.md 主流程中提及

### 步骤 3：调研
- **文档**：`references/xhs-research.md` ✅
- **搜索工具**：anysearch + WebFetch — 明确说明 ✅
- **素材来源表**：完整（小红书/产品官网/用户评价/行业报告/KOL） ✅
- **结构化素材包格式**：完整定义 ✅
- **搜索技巧**：关键词组合/时间限定/多平台 ✅

### 步骤 4：写文案
- **文档**：`references/xhs-writing.md` ✅
- **内容类型**：6 种（种草/测评/攻略/合集/教程/避雷） ✅
- **标题公式**：6 种（数字型/痛点型/悬念型/对比型/情绪型/干货型） ✅
- **emoji 规范**：标题 1-2 个，正文引导符号 — 清晰 ✅
- **字数限制**：300-800 字 — 文档声明 ✅，无代码强制 ⚠️（合理）
- **中文排版**：`references/chinese-copywriting-guidelines.md` 独立引用 ✅

### 步骤 5：生成标签
- **文档**：`references/xhs-tools.md` ✅
- **金字塔搭配**：热门(1-2) + 精准(2-3) + 长尾(2-3) ✅
- **格式**：#话题标签# ✅
- **数量**：5-10 个 ✅

### 步骤 6：封面设计
- **文档**：`templates/README.md` ✅
- **模板数量**：5 个 ✅
  - `minimal.html` — 简约白
  - `bold.html` — 大字报
  - `collage.html` — 拼贴
  - `gradient.html` — 渐变
  - `list.html` — 清单
- **模板格式**：所有 HTML 文件以 `<!DOCTYPE html>` 开头 ✅
- **占位符**：`{{TITLE}}`, `{{SUBTITLE}}`, `{{CATEGORY}}`, `{{ITEM_1}}`~`{{ITEM_5}}` ✅
- ⚠️ 尺寸 1080×1440 (3:4) 在文档中声明，需实际渲染验证
- ⚠️ 深色/浅色模式未在文档中提及

### 步骤 7：打磨
- **文档**：`references/xhs-tools.md` ✅
- **去 AI 味**：Humanizer + StopSlop / 内置 4 轮扫描 ✅
- **体检维度**：5 维度（封面吸引力/标题点击率/正文种草力/标签精准度/互动引导力） ✅
- **输出格式**：打分(1-5) + 具体建议 ✅

### 步骤 8：输出内容包
- **文档**：SKILL.md 内联定义 ✅
- **文件格式**：`.md` + `.html` + `.json` + `guide.md` ✅
- **output/ 目录**：有 `.gitkeep` ✅
- ⚠️ `.gitignore` 排除了 `output/*.html`, `output/*.md`, `output/*.json`，这会导致生成的内容不会被 git 追踪（合理），但 `.gitkeep` 的存在有些矛盾

### 步骤 9：同步发布
- **文档**：`references/xhs-publishing.md` ✅
- **主方案**：Wechatsync CLI 自动同步 ✅
- **备用方案**：`pbcopy` 手动复制 ✅
- **故障排查**：4 步排查流程 ✅
- **发布后流程**：清晰 ✅
- ⚠️ Wechatsync 是外部依赖，需要 `npm install -g @wechatsync/cli` + Chrome 扩展
- ⚠️ SKILL.md 提到 `WECHATSYNC_TOKEN` 环境变量，xhs-setup.md 提到配置 token

### 步骤 10：复盘
- **文档**：`references/xhs-publishing.md` ✅
- **数据追踪**：4 个时间点（1h/24h/72h/7d） ✅
- **指标**：基础(6) + 进阶(4) + 归因(4) ✅
- **复盘报告格式**：完整定义 ✅
- **Obsidian 更新路径**：3 个路径清晰 ✅

---

## 跨领域问题

### 配置 (`references/xhs-setup.md`)
- ✅ 9 步配置流程清晰
- ✅ 配置状态检查表存在
- ✅ 常见问题 FAQ 完整
- ⚠️ `config/xhs.example.json` 中 `obsidian_vault_path` 有硬编码路径 `/Users/souljian/code/opc/opc-knowledge`
- ⚠️ 配置验证仅在文档中描述，无自动化脚本

### 增强工具 (`references/xhs-tools.md`)
- ✅ 爆款标题生成器：6 策略 × 2 = 12 标题，完整
- ✅ 标签推荐器：金字塔搭配，有具体输出格式
- ✅ 笔记体检报告：5 维度打分标准完整
- ✅ 开头 3 行生成器：3 版本（场景/痛点/数据）
- ✅ 封面设计指导：5 种风格 + 配色建议

### 基础设施
- ❌ 无 `.editorconfig`
- ❌ 无 `scripts/` 目录（依赖检查脚本、同步脚本）
- ❌ 无 `CLAUDE.md`
- ❌ 无 `AGENTS.md`
- ✅ `.gitignore` 配置合理

### 测试 (`evals/`)
- ✅ `evals.json`：3 个测试用例（完整流程/爆款拆解/标题生成）
- ✅ `trigger_eval.json`：20 个触发词测试（10 positive + 10 negative）
- ⚠️ 测试用例仅 3 个，未覆盖所有意图路由

---

## 待修复清单

| # | 问题 | 严重度 | 对应任务 |
|---|------|--------|---------|
| 1 | anysearch 安装方式未在 README 前置条件中说明 | ⚠️ | Task 3 |
| 2 | `config/xhs.example.json` 有硬编码路径 | ⚠️ | Task 3 |
| 3 | 封面模板需渲染验证（3:4 尺寸/占位符） | ⚠️ | Task 4 |
| 4 | 配置验证无自动化脚本 | ⚠️ | Task 5 |
| 5 | 无 `.editorconfig` | ❌ | Task 6 |
| 6 | 无 `scripts/` 目录 | ❌ | Task 8 |
| 7 | 无 `CLAUDE.md` | ❌ | Task 8 |
| 8 | evals 覆盖不全 | ⚠️ | Task 3 |
| 9 | output/ 的 .gitignore 与 .gitkeep 矛盾 | ⚠️ | Task 3 |
| 10 | 信源连通性缓存设计好但主 SKILL.md 未提及 | ⚠️ | Task 3 |
