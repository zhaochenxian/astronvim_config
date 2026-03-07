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
      
      -- Python formatter & linters
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.pylint,
      
      -- JavaScript/TypeScript formatter & linter
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.eslint,
      
      -- JSON formatter
      null_ls.builtins.formatting.jq,
      
      -- Shell formatter & linter
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,
      
      -- Markdown formatter
      null_ls.builtins.formatting.markdownlint,
      
      -- YAML linter
      null_ls.builtins.diagnostics.yamllint,
    })
  end,
}
