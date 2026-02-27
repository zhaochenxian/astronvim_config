return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Lua formatter
      null_ls.builtins.formatting.stylua,
      -- Python formatter
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      -- JavaScript/TypeScript formatter
      null_ls.builtins.formatting.prettier,
      -- JSON formatter
      null_ls.builtins.formatting.jq,
      -- Shell formatter
      null_ls.builtins.formatting.shfmt,
      -- Markdown formatter
      null_ls.builtins.formatting.markdownlint,
      -- YAML linter
      null_ls.builtins.diagnostics.yamllint,
    })
  end,
}
