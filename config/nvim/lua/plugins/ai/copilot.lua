---@type LazyPluginSpec
return {
  'github/copilot.vim',
  event = 'LspAttach',
  config = function()
    -- Base config
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ''
    vim.g.copilot_enterprise_uri = 'https://etraid.ghe.com'

    -- Accept suggestion with Ctrl-s
    vim.api.nvim_set_keymap('i', '<C-s>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- State variable for toggle
    local copilot_enabled = true

    -- Define command to toggle copilot
    vim.api.nvim_create_user_command('CopilotToggle', function()
      if copilot_enabled then
        vim.cmd 'Copilot disable'
        copilot_enabled = false
        vim.notify('Copilot disabled', vim.log.levels.INFO)
      else
        vim.cmd 'Copilot enable'
        copilot_enabled = true
        vim.notify('Copilot enabled', vim.log.levels.INFO)
      end
    end, { desc = 'Toggle Copilot suggestions' })

    -- Keymap to toggle copilot quickly
    vim.keymap.set('n', '<leader>cd', '<cmd>CopilotToggle<CR>', { silent = true, desc = 'Toggle Copilot' })
  end,
}
