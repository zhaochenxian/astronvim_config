-- mason.lua
-- Mason / mason-tool-installer config. Declare the set of external tools
-- (LSPs, formatters, linters, debuggers) you want guaranteed to be
-- installed on developer machines. Keep this list minimal and aligned with
-- the language tools used in `lua/plugins/*`.

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
