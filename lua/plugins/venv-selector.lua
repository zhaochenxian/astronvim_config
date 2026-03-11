---@type LazySpec
return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    event = "VeryLazy",
    opts = {
      name = "venv",
      auto_refresh = false,
    },
    keys = {
      { "<Leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python/Conda env" },
      { "<Leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Use cached Python/Conda env" },
    },
  },
}