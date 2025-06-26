return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = function()
    require('conform').setup {

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
      },

      formatters = {
        prettier = {
          require_cwd = true,
          cwd = require('conform.util').root_file {
            'prettierrc.json',
            '.prettierrc',
            '.prettierrc.json',
            'prettier.config.js',
            'package.json',
          },
          prepend_args = function()
            return { '--config', 'prettierrc.json' }
          end,
        },
      },
    }
  end,
}
