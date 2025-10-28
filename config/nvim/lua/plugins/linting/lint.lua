---@type LazyPluginSpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    local eslint_path = '/home/dsaleh/.local/share/eslint_next'
    local eslint_cli = eslint_path .. '/node_modules/.bin/eslint'
    local eslint_config_path = eslint_path .. '/.eslintrc.js'

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

    -- Utility function for checking enable state
    local function lint_enabled(bufnr)
      if vim.g.disable_lint or vim.b[bufnr].disable_lint then
        return false
      end
      return true
    end

    vim.api.nvim_create_autocmd('BufWritePost', {
      group = lint_augroup,
      callback = function()
        -- Debounce using Neovim's own scheduler (simple & safe)
        vim.defer_fn(function()
          if not lint_enabled(0) then
            return
          end
          lint.try_lint()
        end, 120) -- ~120ms debounce
      end,
    })

    vim.keymap.set('n', '<leader>ll', function()
      if lint_enabled(0) then
        lint.try_lint()
      else
        vim.notify('Linting is disabled for this buffer', vim.log.levels.INFO)
      end
    end, { desc = 'Trigger linting for current file' })

    vim.keymap.set('n', '<leader>lf', function()
      vim.cmd('!' .. eslint_cli .. ' --config ' .. eslint_config_path .. ' ' .. vim.api.nvim_buf_get_name(0) .. ' --fix')
    end, { desc = 'Format using custom eslint' })

    vim.keymap.set('n', '<leader>ld', function()
      vim.cmd 'LintDisable!'
    end, { desc = 'Disable linter' })

    vim.keymap.set('n', '<leader>le', function()
      vim.cmd 'LintEnable'
    end, { desc = 'Enable linter' })

    vim.api.nvim_create_user_command('LintDisable', function(args)
      if args.bang then
        vim.b.disable_lint = true
        vim.diagnostic.reset(nil, 0)
      else
        vim.g.disable_lint = true
        vim.diagnostic.reset(nil, 0)
      end
    end, {
      desc = 'Disable auto-lint',
      bang = true,
    })

    vim.api.nvim_create_user_command('LintEnable', function()
      vim.b.disable_lint = false
      vim.g.disable_lint = false
      lint.try_lint()
    end, {
      desc = 'Re-enable auto-lint',
    })
  end,
}
