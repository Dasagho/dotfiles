return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'arkav/lualine-lsp-progress', opt = true },
    { 'mfussenegger/nvim-lint', lazy = true },
  },
  event = 'User AlphaClosed',
}
