# AstroNvim Template

**NOTE:** This is for AstroNvim v5+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository
linux:
```shell
git clone https://github.com/zhaochenxian/astronvim_config ~/.config/nvim
```
win：
```shell
git clone --depth 1 https://github.com/zhaochenxian/astronvim_config $env:LOCALAPPDATA\nvim
```
#### Start Neovim

```shell
nvim
```

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

