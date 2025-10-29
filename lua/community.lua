-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- AstroCommunity 插件是一个社区插件集，提供许多流行的功能模块
  "AstroNvim/astrocommunity",

  -- 导入 Lua 开发相关的插件包
  { import = "astrocommunity.pack.lua" },

  -- 导入 VSCode 的相关功能模块
  { import = "astrocommunity.recipes.vscode" },

  -- 导入与 Copilot 和 nvim-cmp 集成的插件
  { import = "astrocommunity.completion.copilot-vim-cmp" },

  -- 导入 blink-cmp 插件及其扩展模块
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.completion.blink-cmp-tmux" },
  { import = "astrocommunity.completion.blink-cmp-git" },
  { import = "astrocommunity.completion.blink-cmp-emoji" },

  -- 导入 AI 补全相关的功能模块
  { import = "astrocommunity.recipes.ai" },
}
