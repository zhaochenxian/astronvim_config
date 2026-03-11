-- lua/user/init.lua
-- Example user customizations. Put machine or personal settings here.
-- This file is loaded (safely) by `lua/polish.lua` if present.

local function first_existing(paths)
  for _, path in ipairs(paths) do
    local expanded = vim.fn.expand(path)
    if vim.fn.executable(expanded) == 1 or vim.uv.fs_stat(expanded) then return expanded end
  end
end

local function detect_conda_root()
  local candidates = {
    vim.env.MAMBA_ROOT_PREFIX,
    "~/miniconda",
    "~/miniconda3",
    "~/anaconda3",
    "~/opt/miniconda3",
  }

  -- If CONDA_PREFIX points to an env, normalize it back to conda root.
  if vim.env.CONDA_PREFIX and vim.env.CONDA_PREFIX ~= "" then
    local from_prefix = vim.env.CONDA_PREFIX
    if from_prefix:match "/envs/[^/]+$" then
      from_prefix = from_prefix:gsub("/envs/[^/]+$", "")
    end
    table.insert(candidates, 1, from_prefix)
  end

  local conda_exe = vim.fn.exepath "conda"
  if conda_exe ~= "" then
    local inferred = vim.fn.fnamemodify(conda_exe, ":h:h")
    table.insert(candidates, 1, inferred)
  end

  for _, candidate in ipairs(candidates) do
    if candidate and candidate ~= "" then
      local expanded = vim.fn.expand(candidate)
      if vim.uv.fs_stat(expanded) then return expanded end
    end
  end
end

local conda_root = detect_conda_root()
if conda_root then vim.env.CONDA_ROOT = conda_root end

local nvim_py = first_existing {
  "$CONDA_ROOT/envs/neovim/bin/python",
  "~/miniconda/envs/neovim/bin/python",
  "~/miniconda3/envs/neovim/bin/python",
}
local base_py = first_existing {
  "$CONDA_ROOT/bin/python",
  "~/miniconda/bin/python",
  "~/miniconda3/bin/python",
  vim.fn.exepath "python3",
  vim.fn.exepath "python",
}

-- Fixed Python provider for pynvim-based plugins.
vim.g.python3_host_prog = (vim.fn.executable(nvim_py) == 1) and nvim_py or base_py

-- Python path for DAP/LSP: directly use the active conda env or venv.
-- CONDA_PREFIX is already set by conda to the active env directory.
local function sync_python_path_from_env()
  local active = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
  vim.g.python_path = active and (active .. "/bin/python") or vim.g.python3_host_prog
end

sync_python_path_from_env()

-- Normalize conda env vars so AstroUI's virtual_env component can display them.
if vim.env.CONDA_PREFIX and not vim.env.CONDA_DEFAULT_ENV then
  vim.env.CONDA_DEFAULT_ENV = vim.fn.fnamemodify(vim.env.CONDA_PREFIX, ":t")
end

-- Re-sync after plugins load in case any overwrite python_path.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function() vim.defer_fn(sync_python_path_from_env, 200) end,
})

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
