-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.completion.copilot-vim-cmp" },
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.completion.blink-cmp-tmux" },
  { import = "astrocommunity.completion.blink-cmp-git" },
  { import = "astrocommunity.completion.blink-cmp-emoji" },
}
