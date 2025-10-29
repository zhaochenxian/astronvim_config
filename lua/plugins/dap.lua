-- dap.lua
-- Configuration for nvim-dap. This file configures the python adapter.
-- Guidelines:
-- - Avoid hardcoding machine-specific paths. Prefer setting `vim.g.python_path`
--   in `lua/user/init.lua` or an environment variable, or rely on `exepath("python")`.
-- - If you need a different python executable (e.g., conda env), set
--   `vim.g.python_path = '/path/to/python'` in your local `lua/user/init.lua`.

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"

    -- resolve python executable: prefer user override, then env var, then system python
    local python_exe = vim.g.python_path or vim.env.PYTHON_EXECUTABLE or vim.fn.exepath "python" or "python"

    dap.adapters.python = {
      type = "executable",
      command = python_exe,
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "调试 Python 文件",
        program = "${file}",
        -- use resolved python executable; users can override via `vim.g.python_path`
        pythonPath = python_exe,
      },
    }
  end,
}
