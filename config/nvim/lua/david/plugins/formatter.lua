---@type LazyPluginSpec
return {
  'stevearc/conform.nvim',
  dependencies = { 'williamboman/mason.nvim', 'zapling/mason-conform.nvim' },
  event = { 'BufWritePre' },
  config = function()
    conform = require 'conform'
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

      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        go = { 'gopls', 'goimports', 'gofumpt', 'gomodifytags', 'goimports-reviser' },
        yaml = { 'yamlfmt' },
      },
    }
  end,
}
