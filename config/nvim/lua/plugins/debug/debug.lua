---@type LazyPluginSpec
return {
  'mfussenegger/nvim-dap',
  lazy = true,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
  },

  cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapStepInto', 'DapStepOver', 'DapStepOut', 'DapTerminate', 'DapRestartFrame', 'DapToggleRepl' },
  config = function()
    require('config.debug').setup()
  end,
}
