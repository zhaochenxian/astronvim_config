return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Helper function to conditionally include formatters
    local function get_active_sources()
      local sources = {
        -- Always include these universal linters
        null_ls.builtins.diagnostics.yamllint,
      }
      
      -- Lua formatter (always)
      table.insert(sources, null_ls.builtins.formatting.stylua)
      
      -- Python tools - add if Python project detected
      if vim.fn.glob("setup.py", 0, 1)[1] or vim.fn.glob("pyproject.toml", 0, 1)[1] then
        table.insert(sources, null_ls.builtins.formatting.black)
        table.insert(sources, null_ls.builtins.formatting.isort)
        table.insert(sources, null_ls.builtins.diagnostics.flake8)
        table.insert(sources, null_ls.builtins.diagnostics.pylint)
      end
      
      -- JavaScript/TypeScript - add if web project detected
      if vim.fn.glob("package.json", 0, 1)[1] or vim.fn.glob(".eslintrc*", 0, 1)[1] then
        table.insert(sources, null_ls.builtins.formatting.prettier)
        table.insert(sources, null_ls.builtins.diagnostics.eslint)
      end
      
      -- Shell - add if shell files present
      if vim.fn.glob("*.sh", 0, 1)[1] then
        table.insert(sources, null_ls.builtins.formatting.shfmt)
        table.insert(sources, null_ls.builtins.diagnostics.shellcheck)
      end
      
      -- JSON (common, always include)
      table.insert(sources, null_ls.builtins.formatting.jq)
      
      -- Markdown (common, always include)
      table.insert(sources, null_ls.builtins.formatting.markdownlint)
      
      return sources
    end

    -- Only insert new sources, do not replace the existing ones
    opts.sources = require("astrocore").list_insert_unique(opts.sources, get_active_sources())
  end,
}
