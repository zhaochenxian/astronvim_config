-- blink-cmdline.lua
-- Configuration for Saghen/blink.cmp: adds command-line completion and AI keymap helpers.
-- This file customizes `opts` to extend the plugin's built-in behaviors.

return {
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      -- 添加命令行补全配置
      opts.cmdline = {
        sources = function()
          local cmd_type = vim.fn.getcmdtype()
          if cmd_type == "/" then return { "buffer" } end
          if cmd_type == ":" then return { "cmdline" } end
          return {}
        end,
        keymap = {
          preset = "super-tab",
        },
        completion = {
          menu = {
            auto_show = true,
          },
        },
      }

      -- 添加 AI 补全相关配置
      if not opts.keymap then opts.keymap = {} end
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function()
          if vim.g.ai_accept then return vim.g.ai_accept() end
        end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }

      return opts
    end,
  },
}
