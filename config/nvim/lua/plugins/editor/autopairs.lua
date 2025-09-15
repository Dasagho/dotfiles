---@type LazyPluginSpec
return {
  'cohama/lexima.vim',
  event = { 'InsertEnter', 'BufReadPre' },
  config = function()
    vim.g.lexima_enable_basic_rules = 1
    vim.g.lexima_enable_newline_rules = 1
    vim.g.lexima_enable_endwise_rules = 1
  end,
  -- ft = { 'tex', 'markdown', 'vim', 'lua', 'python', 'javascript' }, -- adjust
}
