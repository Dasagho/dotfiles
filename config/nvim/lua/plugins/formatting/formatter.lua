---@type LazyPluginSpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  config = function()
    local conform = require 'conform'

    conform.formatters.prettier = {
      prepend_args = function()
        return {
          '--config',
          vim.fn.expand '/home/dsaleh/.config/prettier/config.json',
        }
      end,
    }
    conform.formatters.black = {
      prepend_args = function()
        return { '--line-length', '79' }
      end,
    }

    conform.setup {
      formatters_by_ft = require('config.formatter').formatters,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
    }

    vim.keymap.set('n', '<leader>ff', function()
      require('conform').format { async = true, lsp_fallback = true }
    end, { desc = 'Format buffer with Conform' })

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
