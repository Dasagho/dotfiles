local M = {}

-- Single source-of-truth adapters table
-- Add/modify entries here to expand supported debuggers.
M.adapters = {
  python = {
    mason = 'python',
    ensure = true,
    dap_key = 'python',
    register = function()
      local ok, dap_python = pcall(require, 'dap-python')
      if ok and dap_python and dap_python.setup then
        dap_python.setup 'python3' -- prefer automatic detection
      else
        vim.notify('dap-python not available; python adapter not registered', vim.log.levels.WARN)
      end
    end,
    check = function()
      return vim.fn.executable 'python3' == 1 or vim.fn.executable 'python' == 1
    end,
  },

  node = {
    mason = 'js',
    ensure = true,
    dap_key = 'pwa-node',
    register = function()
      local js_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'
      if vim.fn.filereadable(js_path) == 1 then
        local dap = require 'dap'
        dap.adapters['pwa-node'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = { command = 'node', args = { js_path, '${port}' } },
        }
      else
        vim.notify('js-debug-adapter or node missing; :MasonInstall js-debug-adapter', vim.log.levels.WARN)
      end
    end,
    check = function()
      local js_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'
      return vim.fn.filereadable(js_path)
    end,
  },

  delve = {
    mason = 'delve',
    ensure = true,
    dap_key = 'go',
    check = function()
      return vim.fn.executable 'dlv' == 1
    end,
  },

  codelldb = {
    mason = 'codelldb',
    ensure = true,
    dap_key = 'codelldb',
    register = function()
      local dap = require 'dap'
      local path1 = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'
      local path2 = vim.fn.stdpath 'data' .. '/mason/bin/codelldb'
      local exe = nil
      if vim.fn.filereadable(path1) == 1 then
        exe = path1
      end
      if not exe and vim.fn.executable(path2) == 1 then
        exe = path2
      end
      if not exe and vim.fn.executable 'codelldb' == 1 then
        exe = 'codelldb'
      end
      if exe then
        dap.adapters.codelldb = { type = 'server', port = '${port}', executable = { command = exe, args = { '--port', '${port}' } } }
      else
        vim.notify('codelldb not found; :MasonInstall codelldb', vim.log.levels.WARN)
      end
    end,
    check = function()
      local p = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'
      return vim.fn.filereadable(p) == 1 or vim.fn.executable 'codelldb' == 1
    end,
  },
}

-- internal helper: build ensure_installed and handlers for mason-nvim-dap
local function build_mason_tables()
  local ensure_installed = {}
  local handlers = {}
  for name, info in pairs(M.adapters) do
    if info.ensure and info.mason then
      table.insert(ensure_installed, info.mason)
    end
    if info.mason then
      handlers[info.mason] = (function(fn)
        return function()
          if type(fn) == 'function' then
            pcall(fn)
          end
        end
      end)(info.register)
    end
  end
  return ensure_installed, handlers
end

-- setup: register adapters via mason-nvim-dap handlers if possible; fallback to manual register
function M.setup()
  local ok, mason_nvim_dap = pcall(require, 'mason-nvim-dap')
  local ensure_installed, handlers = build_mason_tables()
  if ok and mason_nvim_dap then
    mason_nvim_dap.setup {
      automatic_installation = true,
      ensure_installed = ensure_installed,
      handlers = {
        function(config)
          mason_nvim_dap.default_setup(config)
        end,
      },
    }
  else
    vim.notify('mason-nvim-dap not available; registering adapters manually', vim.log.levels.WARN)
    for _, info in pairs(M.adapters) do
      if type(info.register) == 'function' then
        pcall(info.register)
      end
    end
  end

  -- ensure adapters are registered (in case of race)
  for _, info in pairs(M.adapters) do
    if type(info.register) == 'function' then
      pcall(info.register)
    end
  end

  -- create :DapCheckAdapters user command
  vim.api.nvim_create_user_command('DapCheckAdapters', function()
    local missing, present = {}, {}
    for name, info in pairs(M.adapters) do
      local ok = false
      if info.check and type(info.check) == 'function' then
        local status, res = pcall(info.check)
        ok = status and res
      else
        if info.mason and vim.fn.isdirectory(vim.fn.stdpath 'data' .. '/mason/packages/' .. info.mason) == 1 then
          ok = true
        end
        if not ok and info.dap_key and vim.fn.executable(info.dap_key) == 1 then
          ok = true
        end
      end
      if ok then
        table.insert(present, name)
      else
        table.insert(missing, name)
      end
    end

    if #present > 0 then
      vim.notify('Adapters present: ' .. table.concat(present, ', '), vim.log.levels.INFO)
    end
    if #missing > 0 then
      vim.notify('Adapters missing: ' .. table.concat(missing, ', '), vim.log.levels.WARN)
      local suggestions = {}
      for _, n in ipairs(missing) do
        local pkg = M.adapters[n] and M.adapters[n].mason
        if pkg then
          table.insert(suggestions, pkg)
        end
      end
      if #suggestions > 0 then
        vim.notify('Try: :MasonInstall ' .. table.concat(suggestions, ' '), vim.log.levels.WARN)
      end
    else
      vim.notify('All adapters OK', vim.log.levels.INFO)
    end
  end, { desc = 'Check adapters from adapters table' })
end

return M
