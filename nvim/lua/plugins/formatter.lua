return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
      format_on_save = {
        enabled = true,
        allow_filetypes = { "javascript", "typescript", "python", "lua", "sh" },
      },
    }
  end,
}
