local M = {}

function M.setup()
  local ok_dap, _ = pcall(require, 'dap')
  if not ok_dap then
    vim.notify('nvim-dap not found; skipping debug setup', vim.log.levels.WARN)
    return
  end

  local adapters = require 'david.config.debug.adapters'
  adapters.setup()

  local ui = require 'david.config.debug.ui'
  ui.setup()

  require('nvim-dap-virtual-text').setup { commented = true }

  local keys = require 'david.config.debug.keys'
  keys.setup()

  local launch = require 'david.config.debug.launch'
  launch.setup()
end

return M
