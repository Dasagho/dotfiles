---@type LazyPluginSpec
return { -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('todo-comments').setup { signs = false }
  end,
}
