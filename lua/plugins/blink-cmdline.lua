-- blink-cmdline.lua
-- Extension for blink.cmp: command-line completion and AI helpers.
-- AstroNvim handles the main blink.cmp setup; this just adds extras.

return {
  -- Command-line completion
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      -- Explicitly enable command-line completion for ':' and '/'.
      opts.cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
        },
        sources = function()
          local cmd_type = vim.fn.getcmdtype()
          if cmd_type == "/" then return { "buffer" } end
          if cmd_type == ":" then return { "cmdline" } end
          return {}
        end,
      }
      return opts
    end,
  },
}
