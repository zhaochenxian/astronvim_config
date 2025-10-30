-- lua/user/init.lua
-- Example user customizations. Put machine or personal settings here.
-- This file is loaded (safely) by `lua/polish.lua` if present.

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

-- Return a table if you want to expose functions, otherwise nil is fine
return {}
