---@type LazyPluginSpec
return {
  'github/copilot.vim',
  config = function()
    -- vim.g.copilot_proxy = 'http://etraid.ghe.com'
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ''
    vim.g.copilot_enterprise_uri = 'https://etraid.ghe.com'
    vim.api.nvim_set_keymap('i', '<C-s>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
