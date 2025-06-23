return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- ① only when a real buffer is opened from disk
  event = { 'BufReadPost', 'BufNewFile' },
  -- ② never at startup if Neovim was launched without files
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    require('lazy.core.loader').add_to_rtp(plugin)
    require 'nvim-treesitter.query_predicates'
  end,
}
