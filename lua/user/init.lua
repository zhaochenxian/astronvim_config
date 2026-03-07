-- lua/user/init.lua
-- Example user customizations. Put machine or personal settings here.
-- This file is loaded (safely) by `lua/polish.lua` if present.

-- ============================================================================
-- Conda Python Configuration
-- ============================================================================
-- Set Python path for DAP debugger and LSP
-- Using conda base environment
vim.g.python_path = vim.fn.expand("~/miniconda/bin/python")
vim.g.python3_host_prog = vim.fn.expand("~/miniconda/bin/python")

-- Example: simple keymap
-- No custom file-explorer mapping here: neo-tree is already configured with <leader>e in the main config.

-- Example: format on save for lua files (only run if LSP/format available)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    local ok, _ = pcall(function() vim.lsp.buf.format { async = false } end)
    if not ok then
      -- fallback: try stylua if present
      pcall(function() vim.cmd "silent! !stylua %" end)
    end
  end,
})

-- Performance analysis commands
if pcall(require, "lazy") then
  vim.api.nvim_create_user_command("LazyProfile", function()
    require("lazy").stats()
  end, { desc = "Show lazy.nvim plugin loading times" })

  vim.api.nvim_create_user_command("LazyUpdate", function()
    require("lazy").update()
  end, { desc = "Update all lazy.nvim plugins" })
end

-- Treesitter parser statistics
vim.api.nvim_create_user_command("TreesitterStats", function()
  local parsers = require("nvim-treesitter.parsers").get_installed_parsers()
  local count = 0
  for _ in pairs(parsers) do count = count + 1 end
  print(string.format("Installed Treesitter parsers: %d", count))
  for parser in pairs(parsers) do
    print("  - " .. parser)
  end
end, { desc = "Show installed treesitter parsers" })

-- Return a table if you want to expose functions, otherwise nil is fine
return {}
