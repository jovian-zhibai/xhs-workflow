# 配置助手

帮助用户完成首次配置，引导设置各项功能。

## 何时使用

- 用户说"帮我配置"
- 用户说"怎么设置"
- 用户说"配置助手"
- 用户说"检查配置"

## 配置流程

### 第 1 步：检查现有配置

检查 `config/xhs.json` 是否存在，以及哪些已配置、哪些缺失。

**配置文件查找顺序：**
1. `{当前项目}/config/xhs.json` — 项目目录优先
2. `{skill_dir}/config/xhs.json` — Skill 安装目录兜底

**检查内容：**
- 基础配置：author、default_style
- Obsidian 集成：obsidian_vault_path、obsidian素材库_folder
- 同步平台：wechatsync_platforms
- 代理配置：proxy
- 信源配置：topic_sources
- API Key：agnes_api_key

### 第 2 步：选择保存位置

询问用户配置文件保存位置：
- **当前项目目录**：`{项目}/config/xhs.json`（推荐）
- **Skill 目录**：skill 安装位置下的 `config/xhs.json`

### 第 3 步：基础配置

**author（作者昵称）：**
- 询问用户的昵称
- 用于笔记的作者标识

**default_style（默认风格）：**
- 询问用户偏好的内容风格
- 选项：种草、测评、攻略、合集、教程、避雷

### 第 4 步：Obsidian 集成（可选）

询问用户是否需要 Obsidian 集成：
- 用户说"是"：
  - 询问 Obsidian Vault 路径
  - 询问素材库文件夹名称（默认「12-小红书」）
  - 创建目录结构和模板文件
- 用户说"否"：跳过

### 第 5 步：同步平台配置（可选）

询问用户需要同步到哪些平台：
- 小红书（默认开启）
- 抖音图文（可选）

**前置条件检查：**
- Wechatsync CLI 是否安装
- Chrome 扩展是否安装
- 目标平台是否登录

### 第 6 步：代理配置（可选）

询问用户是否需要代理：
- 用户说"是"：
  - 询问代理地址（http 和 https）
- 用户说"否"：跳过

### 第 7 步：API Key 配置（可选）

**agnes_api_key（图片生成）：**
- 询问用户是否需要 AI 生成封面图
- 用户说"是"：询问 API Key
- 用户说"否"：跳过

### 第 8 步：确认配置

展示配置摘要，让用户确认：

```
📋 配置摘要

基础配置：
- 作者昵称：你的小红书昵称
- 默认风格：种草

Obsidian 集成：
- Vault 路径：/Users/souljian/code/opc/opc-knowledge
- 素材库文件夹：12-小红书

同步平台：
- 小红书 ✅
- 抖音图文 ✅

代理配置：未配置

API Key：
- Agnes：未配置

确认保存？[Y/n]
```

### 第 9 步：保存配置

保存到 `config/xhs.json`，并提示配置完成。

## 配置状态检查表

```
📋 配置状态检查

| 功能 | 状态 | 配置项 |
|------|------|--------|
| 写笔记、打磨 | ✅ 可用 | 无需配置 |
| 爆款拆解 | ✅ 可用 | anysearch 已安装 |
| 同步到小红书 | ⚠️ 需配置 | Wechatsync CLI + Chrome 扩展 |
| 同步到抖音 | ⚠️ 需配置 | Wechatsync CLI + Chrome 扩展 |
| Obsidian 素材库 | ⚠️ 需配置 | obsidian_vault_path |
| AI 生成封面 | ⚠️ 需配置 | agnes_api_key |
| 代理访问 | ⚠️ 需配置 | proxy |
```

## 配置文件示例

```json
{
  "author": "你的小红书昵称",
  "obsidian_vault_path": "/Users/souljian/code/opc/opc-knowledge",
  "obsidian素材库_folder": "12-小红书",
  "default_style": "种草",
  "wechatsync_platforms": ["xiaohongshu", "douyin"],
  "proxy": {
    "http": "",
    "https": ""
  },
  "topic_sources": {
    "lifestyle": ["小红书热搜", "微博热搜", "抖音热榜"],
    "beauty": ["小红书美妆", "YouTube美妆", "Instagram"],
    "food": ["下厨房", "小红书美食", "大众点评"],
    "travel": ["马蜂窝", "小红书旅行", "携程"]
  },
  "agnes_api_key": "",
  "output_dir": "output"
}
```

## 配置验证

配置完成后，验证各项功能是否正常：

| 功能 | 验证命令 | 预期结果 |
|------|---------|---------|
| anysearch | `anysearch search "测试"` | 返回搜索结果 |
| Wechatsync | `wechatsync platforms --auth` | 显示登录状态 |
| Obsidian | 检查 Vault 路径是否存在 | 目录存在 |
| 代理 | `curl -x {proxy} https://google.com` | 能访问 |

## 常见问题

### Q: 配置文件在哪里？

配置文件支持两个位置（当前目录优先）：
1. `{当前项目}/config/xhs.json`
2. `{skill_dir}/config/xhs.json`

### Q: 如何修改配置？

直接编辑 `config/xhs.json` 文件，或重新运行配置助手。

### Q: 配置文件会泄露吗？

不会。`config/xhs.json` 已在 `.gitignore` 中排除，不会提交到 Git。

### Q: Wechatsync 如何安装？

```bash
npm install -g @wechatsync/cli
```

然后在 Chrome 安装「文章同步助手」扩展。

### Q: Obsidian 集成是什么？

将爆款素材库存储在 Obsidian Vault 中，支持可视化浏览和知识积累。配置 `obsidian_vault_path` 后，AI 可以直接读写 Obsidian 中的素材。
