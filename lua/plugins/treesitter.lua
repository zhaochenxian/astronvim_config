-- treesitter.lua
-- Treesitter parser configuration. List parsers you commonly use here.
-- Prefer keeping this list focused to reduce install time and maintenance.

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
