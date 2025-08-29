---@type LazyPluginSpec
return {
  'folke/twilight.nvim',
  config = function(_, opts)
    vim.keymap.set('n', '<leader>tt', function()
      require('twilight').toggle()
    end, { desc = 'Toggle Twilight' })
  end,
}
