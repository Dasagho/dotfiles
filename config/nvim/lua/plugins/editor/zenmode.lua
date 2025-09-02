---@type LazyPluginSpec
return {
  'folke/twilight.nvim',
  cmd = 'Twilight',
  config = function(_, opts)
    vim.keymap.set('n', '<leader>tt', "<cmd>Twilight<CR>", { desc = 'Toggle Twilight' })
  end,
}
