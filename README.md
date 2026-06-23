# xhs-workflow

> 小红书图文笔记全流程工作流 — 从爆款拆解到发布，一站式完成

一个 AI Agent skill，帮你完成小红书笔记创作的全链路。兼容 Claude Code、Cursor、Windsurf 等支持 skill 的 Agent 工具：

```
爆款拆解 → 选题 → 调研 → 写文案 → 生成标签 → 封面设计 → 打磨 → 输出内容包 → 同步发布 → 复盘
```

支持**全自动**（无人值守）和**半自动**（交互式确认）两种模式。

---

## 功能特性

| 阶段 | 能力 |
|------|------|
| 🔍 爆款拆解 | 搜索同类爆款，拆解标题/封面/正文/标签，提炼爆款公式 |
| 📡 选题 | 三模式扫描（热点速报/深度选题/预判选题）+ 爆款公式匹配 |
| 📋 调研 | 竞品笔记分析、素材搜集、结构化素材包 |
| ✍️ 写文案 | 300-800 字短文，emoji 点缀，种草风格 |
| 🏷️ 标签 | 金字塔搭配（热门+精准+长尾） |
| 🎨 封面 | 5 种风格模板，根据爆款拆解结果自动选择 |
| 💎 打磨 | 去 AI 味（Humanizer + StopSlop / 内置 4 轮扫描）、笔记体检报告 |
| 📦 输出 | 打包文案 + 标签 + 封面 + 发布指引 |
| 🚀 同步 | DraftPush 一键推送到草稿箱（推荐）/ Wechatsync 备选 |
| 📊 复盘 | 数据追踪、经验总结、更新爆款公式 |
| 💾 素材库 | Obsidian 集成，爆款素材持久化存储 |

---
## 前置条件

### 必须

无需额外安装，核心功能（写笔记、打磨、去 AI 味）开箱即用。

### 推荐

| 依赖 | 用途 | 安装方式 |
|------|------|---------|
| anysearch skill | 爆款拆解、选题搜索 | `npx skills add pinkpromise/anysearch` |
| DraftPush 扩展 | 一键同步到小红书草稿箱 | [GitHub](https://github.com/jovian-zhibai/draftpush) |
| Obsidian | 素材库持久化存储 | [obsidian.md](https://obsidian.md) |

### 可选

| 依赖 | 用途 | 安装方式 |
|------|------|---------|
| Agnes AI API | AI 生成封面图 | 配置 `agnes_api_key` |
| SenseNova API | AI 生成封面图（备选） | 配置 `sensenova_api_key` |
| Wechatsync CLI | 同步到草稿箱（备选方案） | `npm install -g @wechatsync/cli` |
| Chrome 扩展 | Wechatsync 浏览器连接 | Chrome 商店搜索「文章同步助手」 |

### 检查依赖

```bash
bash scripts/xhs-check-deps.sh
```

---

## 快速开始

### 1. 安装

```bash
npx skills add jovian-zhibai/xhs-workflow
```

更新到最新版本：

```bash
npx skills update xhs-workflow
```

### 2. 使用

在支持 skill 的 Agent 工具中调用 skill，再输入指令：

```
> /xhs-workflow
> 帮我写篇小红书
```

常用指令：

| 指令 | 说明 |
|------|------|
| 帮我配置 | 配置助手，引导完成各项设置 |
| 帮我写篇小红书 | 完整流程：爆款拆解 → 发布 |
| 帮我拆解一下 XX 的爆款 | 只执行爆款拆解 |
| 帮我写篇关于护肤的笔记 | 跳过选题，从调研开始 |
| 全自动帮我写完直接发 | 无人值守模式 |
| 帮我想几个标题 | 单独调用爆款标题生成器 |
| 帮我看看这篇笔记怎么样 | 调用笔记体检报告 |
| 同步到小红书 | 发布后同步到小红书草稿箱 |

---

## 配置

```bash
cp config/xhs.example.json config/xhs.json
```

配置文件支持两个位置（当前项目目录优先）：

| 功能 | 是否必须 | 配置项 |
|------|---------|--------|
| 写笔记、打磨 | ✅ 必须 | 无，开箱即用 |
| 爆款拆解 | 推荐 | anysearch skill |
| 同步到小红书/抖音 | 推荐 | DraftPush 扩展 |
| Obsidian 素材库 | 推荐 | `obsidian_vault_path` |
| AI 生成封面图 | 可选 | `agnes_api_key` |

### 安装 anysearch（推荐）

anysearch 用于搜索小红书热搜、微博热搜等信源，是爆款拆解和选题的核心依赖：

```bash
npx skills add pinkpromise/anysearch
```

说"帮我配置"可以引导完成所有设置。

---

## 爆款拆解

核心功能之一。通过搜索同类爆款笔记，拆解成功要素：

```
搜索关键词 → 筛选 Top 10 爆款 → 逐篇拆解 → 提炼爆款公式 → 保存到 Obsidian
```

**拆解维度：**
- 标题公式（数字型/痛点型/悬念型/对比型/情绪型/干货型）
- 封面风格（对比图/大字报/拼贴/渐变/清单）
- 正文结构（开头→干货→结尾）
- 标签策略（热门+精准+长尾）
- 互动引导（提问/投票/求收藏）

拆解结果保存到 Obsidian 素材库，持续积累爆款知识。

---

## Obsidian 集成

素材库存储在 Obsidian Vault 中，支持可视化浏览和知识积累：

```
12-小红书/
├── _index.md                 # 索引页
├── 爆款公式/                 # 拆解出的通用规律
├── 素材库/                   # 按行业分类的拆解素材
├── 关键词/                   # 按关键词索引
└── 数据追踪/                 # 发布后的数据记录
```

配置 `obsidian_vault_path` 后，AI 可以直接读写 Obsidian 中的素材。

---

## 项目结构

```
xhs-workflow/
├── SKILL.md                    # skill 入口
├── CLAUDE.md                   # Claude Code 项目指南
├── config/
│   ├── xhs.example.json        # 配置模板
│   └── connectivity.json       # 信源连通性缓存（自动生成，不提交）
├── references/                 # 各阶段详细指引
│   ├── xhs-inspiration.md      # 选题（含爆款拆解）
│   ├── xhs-research.md         # 调研
│   ├── xhs-writing.md          # 撰写
│   ├── xhs-tools.md            # 增强工具集
│   ├── xhs-publishing.md       # 发布 + 复盘
│   ├── xhs-setup.md            # 配置助手
│   └── chinese-copywriting-guidelines.md  # 中文排版规范
├── scripts/                    # 自动化脚本
│   ├── xhs-check-deps.sh       # 依赖检查
│   ├── xhs-sync.sh             # Wechatsync 同步封装
│   └── xhs-generate-cover.sh   # 封面图生成
├── templates/                  # 5 个精美封面模板
├── output/                     # 生成的笔记输出目录
├── evals/                      # 测试用例
└── .dev/                       # 开发文档
    └── CHAIN_AUDIT.md          # 全链路审计报告
```

---

## 内容类型

| 类型 | 特点 | 示例 |
|------|------|------|
| 种草笔记 | 推荐好物，真实体验 | 「这个面霜救了我的烂脸！」 |
| 测评笔记 | 横向对比，客观分析 | 「6款平价防晒实测」 |
| 攻略笔记 | 完整解决方案 | 「成都3天2夜保姆级攻略」 |
| 合集笔记 | 同类汇总整理 | 「30件厨房好物合集」 |
| 教程笔记 | 手把手教学 | 「零基础修图教程」 |
| 避雷笔记 | 踩坑经验分享 | 「装修5个大坑」 |

---

## 同步发布

### 方案一：DraftPush 一键推送（推荐）

通过 DraftPush Chrome 扩展，Skill 写完后自动同步到小红书草稿箱：

1. 安装 [DraftPush](https://github.com/jovian-zhibai/draftpush) Chrome 扩展
2. 在配置中开启：`draftpush.enabled: true`
3. Skill 写完笔记后，内容自动出现在插件面板，一键推送

### 方案二：Wechatsync（备选）

如果不使用 DraftPush，仍可通过 Wechatsync 同步：

```bash
# 同步到小红书草稿箱
wechatsync sync output/xxx.md -p xiaohongshu -t "标题"

# 同步到抖音图文草稿箱
wechatsync sync output/xxx.md -p douyin -t "标题"
```

同步后文章进入草稿箱，用户自行检查排版和发布。

**前置条件：**
- `npm install -g @wechatsync/cli`
- Chrome 安装文章同步助手扩展
- 在浏览器里登录小红书/抖音账号

---

## 注意事项

- 小红书没有官方发布 API，推荐使用 DraftPush 扩展同步到草稿箱
- 封面图使用 HTML 内联样式，可直接在浏览器中截图使用
- 标签数量建议 5-10 个，采用金字塔搭配策略
- 黄金发布时间：7-9 点、12-14 点、19-21 点

---

## 测试

```bash
# 依赖检查
bash scripts/xhs-check-deps.sh

# evals 测试用例覆盖所有 9 条意图路由 + 增强工具
# 参见 evals/evals.json（12 个测试用例）和 evals/trigger_eval.json（触发词测试）
```

---

## License

MIT
