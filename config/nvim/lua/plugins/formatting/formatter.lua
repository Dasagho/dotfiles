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

    conform.setup {
      format_on_save = function(bufnr)
        local disable = { c = true, cpp = true }
        if disable[vim.bo[bufnr].filetype] then
          return nil
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,

      formatters_by_ft = require('config.formatter').formatters,
    }

    vim.keymap.set('n', '<leader>ff', function()
      require('conform').format { async = true, lsp_fallback = true }
    end, { desc = 'Format buffer with Conform' })
  end,
}
