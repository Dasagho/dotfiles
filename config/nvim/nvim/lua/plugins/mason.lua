return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  build = ":MasonUpdat.Providere",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  cmd = { "Mason", "MasonInstall" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = {
        -- lsp
        "ts_ls",
        "html",
        "clangd",
        "cssls",
        "jsonls",
        "marksman",
        "lua_ls",
        "dockerls",
        "docker_compose_language_service",
        "pyright",
        "sqls",
        "yamlls",
        "phpactor",
        "bashls",
        "emmet_ls",
      },
      automatic_installation = true,
    }
    vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.PATH
  end,
}
