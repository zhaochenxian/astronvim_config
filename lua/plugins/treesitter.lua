-- treesitter.lua
-- Treesitter parser configuration. List parsers you commonly use here.
-- Prefer keeping this list focused to reduce install time and maintenance.

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- Core editors & vim
      "lua",
      "vim",
      "vimdoc",
      -- Web development (most common)
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      -- Backend & scripting
      "python",
      "bash",
      -- System programming
      "c",
      "cpp",
      -- Documentation & markup
      "markdown",
      "markdown_inline",
      "yaml",
    },
    -- Auto install parsers
    auto_install = true,
    -- Enable syntax highlighting
    highlight = {
      enable = true,
      -- Disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    -- Enable indentation
    indent = { enable = true },
  },
}
