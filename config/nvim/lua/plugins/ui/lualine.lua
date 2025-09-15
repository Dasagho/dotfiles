---@type LazyPluginSpec
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'arkav/lualine-lsp-progress', opt = true },
  },
  event = 'User AlphaClosed',
  config = function()
    require 'config.lualine'
  end,
}
