return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = function(_, opts)
    opts.notify_on_error = false

    opts.format_on_save = function(bufnr)
      local disable = { c = true, cpp = true }
      if disable[vim.bo[bufnr].filetype] then
        return nil
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end

    opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { 'prettierd', stop_after_first = true },
      typescript = { 'prettierd', stop_after_first = true },
      javascriptreact = { 'prettierd', stop_after_first = true },
      typescriptreact = { 'prettierd', stop_after_first = true },
    })

    opts.formatters = opts.formatters or {}
    opts.formatters.prettierd = {
      require_cwd = true,
      cwd = require('conform.util').root_file {
        'prettierrc.json',
        '.prettierrc',
        '.prettierrc.json',
        'prettier.config.js',
        'package.json',
      },
      prepend_args = { '--config', vim.fn.getcwd() .. '/prettierrc.json' },
    }
  end,
}
