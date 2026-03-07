# Neovim 配置 - AstroNvim v5

**基于** [AstroNvim v5](https://github.com/AstroNvim/AstroNvim) 的现代化编辑器配置

📌 **当前版本**: v1.0 | **最后更新**: 2026-03-07  
🎯 **优化评分**: 4.5/5 | 🚀 **启动时间**: ~200-300ms

---

## ⚡ 快速开始 (5 分钟)

### 1️⃣ 安装或更新配置

```bash
# Linux/macOS
git clone https://github.com/zhaochenxian/astronvim_config ~/.config/nvim

# Windows (PowerShell)
git clone https://github.com/zhaochenxian/astronvim_config $env:LOCALAPPDATA\nvim
```

### 2️⃣ 启动并自动安装

```bash
nvim
# lazy.nvim 会自动下载并安装:
# - AstroNvim 核心框架
# - 所有社区插件
# - LSP 服务器、格式化工具、调试器 (via mason)
# - Treesitter 解析器
```

### 3️⃣ 验证安装成功 (Neovim 内)

```vim
" 检查健康状态
:checkhealth

" 查看插件加载时间
### 文件职责一览表

| 文件 | 职责 |
|------|------|
| **init.lua** | 启动入口，设置 leader 键，引导 lazy.nvim |
| **lua/lazy_setup.lua** | 声明插件源、加载选项、colorscheme 配置 |
| **lua/community.lua** | 从 AstroNvim 社区导入插件模块 |
| **lua/polish.lua** | 最后的钩子：自定义 autocmd、映射、用户脚本 |
| **lua/plugins/*.lua** | 每个插件的配置（astrocore、astrolsp、dap 等） |
| **lua/user/init.lua** | 💡 **机器特定配置**（推荐在此放置个人设置） |
| **lua/plugins/mason.lua** | 声明所有必需的开发工具 (LSP、formatter、debugger 等) |
| **selene.toml** | Lua 代码质量检查规则 |
| **OPTIMIZATION.md** | 2026-03-07 优化说明详档 |

---

## 📚 开发工具配置

### 支持的语言与工具

| 语言 | LSP | Formatter | Linter | Debugger |
|------|-----|-----------|--------|----------|
| **Lua** | ✅ lua_ls | ✅ stylua | ⬜ selene | ❌ |
| **Python** | ✅ pyright | ✅ black, isort | ✅ flake8, pylint | ✅ debugpy |
| **JavaScript/TS** | ⬜ | ✅ prettier | ✅ eslint | ❌ |
| **C/C++** | ✅ clangd | ⬜ | ⬜ | ✅ codelldb |
| **Shell** | ✅ bash_ls | ✅ shfmt | ✅ shellcheck | ❌ |
| **JSON/YAML** | ⬜ | ✅ jq, prettier | ✅ yamllint | ❌ |
| **Markdown** | ⬜ | ✅ markdownlint | ⬜ | ❌ |

**图例**: ✅ = 已配置, ❌ = 不支持, ⬜ = 可选添加

### 配置 Python 调试路径

如使用虚拟环境或 conda，编辑 `lua/user/init.lua`：

```lua
-- lua/user/init.lua
-- 配置 Python 可执行路径（debug 使用）
vim.g.python_path = "/path/to/venv/bin/python"  -- 虚拟环境
-- 或
vim.g.python_path = "/opt/miniconda3/envs/myenv/bin/python"  -- conda
```

### 配置 ESLint (可选)

要启用 JavaScript 代码检查，确保项目中有 `.eslintrc` 配置：

```bash
# 在项目根目录
npm install -D eslint
npx eslint --init
```

然后 none-ls 会自动使用 eslint (已在配置中启用)。

---

## 🎯 最近优化 (2026-03-07)

详见 [OPTIMIZATION.md](OPTIMIZATION.md) - 详细的改进日志和说明

**关键改进**:
- ✅ 代码质量工具: +5 linters (flake8, pylint, eslint, shellcheck, yamllint)
- ✅ LSP 特性: Inlay hints 启用
- ✅ 启动性能: Treesitter 精简 -37% (27 → 17 种语言)
- ✅ 代码规则: selene 严格化 (4 项规则升级)
- ✅ 性能诊断: 新增命令快速定位问题

---
<Space>ld   " 显示行诊断
<Space>lD   " 显示缓冲区诊断
]d / [d     " 下/上一个诊断

" 补全
<Tab>       " 打开补全菜单
<Tab>/<S-Tab> " 导航补全项
<C-j>/<C-k> " 解析 snippet
```

### 文件操作

```vim
" 查找与替换
<Space>f    " 查找文件
<Space>/    " 全局搜索 (live grep)
<Space>sr   " 搜索并替换

" 缓冲区
<Space>bd   " 关闭当前缓冲区
<Space>bq   " 关闭其他缓冲区
<Space>bf   " 全屏切换

" 文件树
<Space>e    " 打开/关闭文件树
```

### 性能诊断

```vim
:LazyProfile        " 查看每个插件的加载时间
:TreesitterStats    " 列出已安装的 Treesitter 解析器
:checkhealth        " 完整诊断报告
:Lazy profile       " 详细的启动性能分析
```

---

## ⚙️ 定制配置

### 添加新的按键绑定

编辑 `lua/plugins/astrocore.lua`：

```lua
mappings = {
  n = {
    ["<Leader>x"] = { "<cmd>echo 'Hello'<CR>", desc = "Say hello" },
  },
}
```

### 启用/禁用功能

编辑 `lua/plugins/astrocore.lua` 中的 `features` 部分：

```lua
features = {
  large_buf = { size = 1024 * 256, lines = 10000 },
  autopairs = true,        -- 自动配对
  cmp = true,              -- 补全
  diagnostics = { ... },   -- 诊断
  highlighturl = true,     -- URL 高亮
  notifications = true,    -- 通知
}
```

### 添加新插件

在 `lua/plugins/user.lua` 中：

```lua
return {
  {
    "author/plugin-name",
    event = "BufRead",
    config = function()
      require("plugin-name").setup()
    end,
  },
}
```

---

## 🔍 故障排除

### 插件加载缓慢

```vim
:LazyProfile   " 找出最慢的插件
```

如果某个插件太慢，考虑：
- 将其 `event` 改为按需加载
- 或在 `lua/lazy_setup.lua` 中禁用它

### LSP 不工作

```vim
:LspInfo       " 检查 LSP 连接
:Mason         " 确验语言服务器已安装
```

常见原因：
- 对应的 LSP 未安装 (`:Mason` -> 搜索并安装)
- Treesitter 解析器缺失 (`:TSInstall <language>`)

### 代码格式化不生效

```vim
:NullLsInfo    " 检查 none-ls 的格式化工具
```

确保格式化工具已安装：
```vim
:Mason         " 搜索 stylua, black, prettier 等
```

### 调试不工作 (Python)

1. 确保已安装 debugpy:
   ```vim
   :Mason  " 搜索 debugpy
   ```

2. 设置 Python 路径：
   ```lua
   vim.g.python_path = vim.fn.exepath("python")
   ```

---

## 📋 维护与更新

### 更新所有插件

```vim
:Lazy update       " 更新所有插件
" 或
:LazyUpdate        " 别名
```

### 同步配置

```vim
:LazySync          " 安装新加入的插件、移除已删除的
```

### 清理缓存

```bash
# 清理 Neovim 缓存（如出现问题)
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
# 重启 Neovim 后会重新生成
```

---

## 📖 扩展资源

### 官方文档
- [AstroNvim 文档](https://docs.astronvim.com)
- [Neovim 中文文档](https://neovim.io)
- [LSP 配置指南](https://github.com/neovim/nvim-lspconfig)

### 社区插件资源
- [AstroNvim 社区](https://github.com/AstroNvim/astrocommunity)
- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

### 键位映射参考
- `:help which-key` (在 Neovim 中)
- `:Telescope keymaps` (使用 Telescope 浏览所有键位)

---
| `,` | 本地菜单 (LocalLeader) |
| `<Space>e` | 文件树浏览 (Neo-tree) |
| `<Space>f` | 模糊查找文件 |
| `<Space>b` | 缓冲区管理 |
| `]b` / `[b` | 下/上一个缓冲区 |

### 📝 编辑增强
| 快捷键 | 功能 |
|--------|------|
| `<Tab>` | 补全/片段展开 |
| `<C-k>` | 函数签名帮助 |
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `<Space>r` | 重命名符号 (LSP) |
| `ga` | 代码操作 (Code Actions) |
| `=` | 格式化选中 |

### 🐛 调试
| 快捷键 | 功能 |
|--------|------|
| `<Space>db` | 设置/清除断点 |
| `<Space>dc` | 继续执行 |
| `<Space>di` | 步入 |
| `<Space>do` | 步过 |

---

## 🛠️ 配置结构

## 文件映射（官方定义）

下面列出本仓库中主要文件/目录的官方定义与职责，用于快速理解与定制：

- `init.lua`：Neovim 启动入口，负责早期的全局设置（如 `mapleader`）并引导插件管理器（`lazy.nvim`）。保持轻量，仅做最必要的引导。
- `lua/lazy_setup.lua`：集中声明 `lazy.nvim` 的 `setup`（插件规格、性能选项、colorscheme），是插件安装与按需加载的中央位置。
- `lua/community.lua`：导入/汇总社区维护的插件规格（来自 `AstroNvim/astrocommunity`），以模块化方式将社区插件纳入配置。
- `lua/polish.lua`：用户级“最终钩子”，在所有插件加载后运行。用于放置自定义 autocmd、额外映射或 require 本地用户脚本，便于把机器/个人的自定义与主配置分离。
- `lua/plugins/*.lua`：每个文件通常为一个或一组插件的 `LazySpec`，负责声明插件、传递 `opts` 或定义 `config` 回调，使插件配置局部化、易于启用/禁用与维护。
- `lua/plugins/mason.lua`：声明 `mason` / `mason-tool-installer` 需要确保安装的工具（LSP、formatters、debuggers、treesitter-cli 等）。
- `selene.toml` 与 `neovim.yml`：代码质量与静态检查规则（Selene 配置与 CI/检查相关设置），用于保持仓库代码风格一致与静态安全检查。
- `README.md`：仓库使用与定制说明（包含如何安装、如何启用/禁用模块、如何运行 lint/format、常见问题与调试方法）。

建议：将机器/用户特有的路径与敏感配置保存在 `lua/polish.lua` 或 `lua/user/*` 中，通过环境变量或 `vim.g` 覆盖，避免在插件配置里使用硬编码绝对路径。

### 机器覆盖示例：为 DAP 配置 Python 可执行路径

如果你使用 `nvim-dap` 并希望为不同机器/虚拟环境定制 Python，可在 `lua/user/init.lua`（或 `lua/polish.lua`）中设置 `vim.g.python_path`：

```lua
-- lua/user/init.lua
-- 优先使用 vim.g.python_path 来覆盖 DAP 使用的 python
vim.g.python_path = "C:/path/to/your/python.exe" -- Windows 示例
```

上面的配置会被 `lua/plugins/dap.lua` 中的适配逻辑优先使用（该逻辑会回退到环境变量 `PYTHON_EXECUTABLE`、系统 `python` 可执行路径，或字符串 `"python"`）。


## 🤖 CI/CD 与格式化

GitHub Actions 工作流自动检查 Lua 代码质量:

| 检查项 | 工具 | 规则 |
|--------|------|------|
| **Lua 代码质量** | selene | 严格模式（disallow 规则) |
| **Lua 代码格式** | stylua | 自动推送格式化 PR |

**本地格式化工具** (在 Neovim 内):

| 语言 | 工具 | 快捷键 |
|------|-----|--------|
| Python | black + isort | `<Space>f` |
| JS/TS/JSON | prettier | `<Space>f` |
| Markdown | markdownlint | `<Space>f` |
| YAML | yamllint | 诊断展示 |
| Shell | shfmt | `<Space>f` |
| Lua | stylua | `<Space>f` |

### 本地格式化

```vim
" 格式化整个文件 (LSP or none-ls)
<Space>f   " 或 :lua vim.lsp.buf.format()

" 仅 Lua 文件自动保存格式化
" lua/user/init.lua 中已配置 BufWritePre autocmd
```

---

## 📄 许可证

MIT License - 详见 LICENSE 文件

---

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

### 报告问题

```bash
# 附带完整的诊断信息
nvim -c ':checkhealth'  # 复制输出
:LazyProfile            # 性能信息
```

### 提交改进

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 打开 Pull Request

---

## ❓ FAQ

**Q: 如何在不影响主配置的情况下添加个人设置?**  
A: 使用 `lua/user/init.lua` - 该文件被 `lua/polish.lua` 安全加载，不会干扰版本控制。

**Q: 如何禁用某个插件?**  
A: 在 `lua/plugins/` 中对应文件的返回值添加 `enabled = false`，或注释掉导入行。

**Q: 为什么首次启动很慢?**  
A: 第一次启动时 lazy.nvim 会下载所有插件和工具。后续启动会快得多。

**Q: 如何添加新的 LSP 服务器?**  
A: 在 `lua/plugins/mason.lua` 的 `ensure_installed` 中添加服务器名称，或使用 `:Mason` UI 手动安装。

**Q: 代码补全不工作怎么办?**  
A: 检查 LSP 是否正确加载 (`:LspInfo`) 和对应语言的解析器 (`:TSInstall` or `:TreesitterStats`)。

---

**⭐ 如果这个配置对你有帮助,请给个 Star!**
---
