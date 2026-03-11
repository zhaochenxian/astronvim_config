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
      search = {
        miniconda_base = {
          command = "$FD '/python$' '$CONDA_ROOT/bin' ~/miniconda/bin ~/miniconda3/bin ~/anaconda3/bin --no-ignore-vcs --full-path --color never",
          type = "anaconda",
        },
        miniconda_envs = {
          command = "$FD 'bin/python$' '$CONDA_ROOT/envs' ~/miniconda/envs ~/miniconda3/envs ~/anaconda3/envs --no-ignore-vcs --full-path --color never",
          type = "anaconda",
        },
      },
      options = {
        on_venv_activate_callback = function()
          local ok, vs = pcall(require, "venv-selector")
          if ok then
            local venv_path = vs.venv()
            local env_name = venv_path and vim.fn.fnamemodify(venv_path, ":t") or nil

            if vim.env.CONDA_PREFIX and env_name and not vim.env.VIRTUAL_ENV then
              vim.env.CONDA_DEFAULT_ENV = env_name
            elseif vim.env.VIRTUAL_ENV then
              vim.env.CONDA_DEFAULT_ENV = nil
            end
          end

          vim.schedule(function()
            vim.api.nvim_exec_autocmds("User", { pattern = "VenvSelectorStatusline", modeline = false })
            vim.cmd.redrawstatus()
          end)
        end,
      },
    },
    keys = {
      { "<Leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python/Conda env" },
      { "<Leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Use cached Python/Conda env" },
    },
  },
}