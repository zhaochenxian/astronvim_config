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
        -- === Core Language Servers ===
        -- 必需的语言服务器
        "lua-language-server",    -- Lua development
        "clangd",                 -- C/C++ development
        "pyright",                -- Python type checking
        "bash-language-server",   -- Shell script support

        -- === Optional Language Servers ===
        -- 取消下面的注释以启用更多语言支持
        -- "typescript-language-server", -- TypeScript/JavaScript LSP
        -- "gopls",                      -- Go language server
        -- "rust-analyzer",              -- Rust language server
        -- "vimls",                      -- VimScript
        -- "jsonls",                     -- JSON with schemas
        -- "yamlls",                     -- YAML with schema validation

        -- === Formatters (Code Styling) ===
        "stylua",                 -- Lua formatter
        "black",                  -- Python formatter
        "prettier",               -- JS/TS/JSON/YAML/Markdown formatter
        "shfmt",                  -- Shell formatter
        -- "isort",                -- Python import sorter (optional, handled via none-ls)

        -- === Linters (Code Quality) ===
        "eslint-lsp",             -- JavaScript/TypeScript linter
        "pylint",                 -- Python linter
        "flake8",                 -- Python style/error checker
        "shellcheck",             -- Shell script checker

        -- === Debuggers ===
        "debugpy",                -- Python debugger
        "codelldb",               -- C/C++ debugger (LLDB)
        -- Debuggers for other languages can be added here:
        -- "js-debug-adapter",     -- JavaScript debugger
        -- "delve",                -- Go debugger

        -- === Build Tools & Parsers ===
        "tree-sitter-cli",        -- Treesitter parser generator
      },
    },
  },
}
