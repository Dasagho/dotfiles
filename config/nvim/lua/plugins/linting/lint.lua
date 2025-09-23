---@type LazyPluginSpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    local eslint_path = '/home/dsaleh/.local/share/eslint_with_node_14'
    local eslint_cli = eslint_path .. '/node_modules/.bin/eslint'
    local eslint_config_path = eslint_path .. '/.eslintrc.json'

    lint.linters.eslint_d = lint.linters.eslint_d or {}
    lint.linters.eslint_d.cmd = eslint_cli
    lint.linters.eslint_d.args = lint.linters.eslint_d.args or {}

    lint.linters.eslint_d.args = {
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
      '--config',
      eslint_config_path,
    }

    lint.linters_by_ft = require('config.lint').linters

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>ll', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })

    vim.keymap.set('n', '<leader>lf', function()
      vim.cmd('!' .. eslint_cli .. ' --config ' .. eslint_config_path .. ' ' .. vim.api.nvim_buf_get_name(0) .. ' --fix')
    end, { desc = 'Format using custom eslint' })
  end,
}
