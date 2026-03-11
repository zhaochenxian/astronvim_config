-- copilot.lua
-- GitHub Copilot integration for AI-powered code completion.

return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable default Tab mapping to avoid conflicts with blink.cmp.
      vim.g.copilot_no_tab_map = true

      -- Official accept mapping: must return a key sequence in expr mode.
      vim.keymap.set("i", "<C-]>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        noremap = true,
        silent = true,
        replace_keycodes = false,
      })

      -- Optional helpers to cycle suggestions.
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { silent = true })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true })
    end,
  },
}
