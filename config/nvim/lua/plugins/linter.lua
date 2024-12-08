return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufReadPost" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}