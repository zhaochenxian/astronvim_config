-- dap.lua
-- Python DAP configuration. Python path comes from venv-selector at runtime.

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"

    -- Always ask venv-selector for the current python; fall back to active env or system.
    local function current_python()
      local ok, vs = pcall(require, "venv-selector")
      if ok then
        local py = vs.venv()
        if py and py ~= "" and vim.fn.executable(py) == 1 then return py end
      end
      local fallback = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
      if fallback then return fallback .. "/bin/python" end
      return vim.fn.exepath("python3") or "python"
    end

    dap.adapters.python = function(callback, _)
      callback { type = "executable", command = current_python(), args = { "-m", "debugpy.adapter" } }
    end

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "调试 Python 文件",
        program = "${file}",
        pythonPath = current_python,
      },
    }
  end,
}
