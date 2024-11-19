return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", "jay-babu/mason-nvim-dap.nvim" },
  build = ":MasonUpdate",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  cmd = { "Mason", "MasonInstall" },
  config = function()
    require("mason").setup()
    require("mason-nvim-dap").setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        -- Aquí puedes listar los adaptadores DAP que quieres que se instalen automáticamente
        -- Por ejemplo: "python", "cppdbg", "js", "node2"
        "php",
        "delve",
        "js",
        "node2",
        "python",
      },
    }
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
        -- dap
        --     "js-debug-adapter",
        --     "node-debug2-adapter",
        --     "delve",
        --     "phpactor",
        --     -- formaters
        --     "standardjs",
        --     "stylua",
        --     "shfmt"
      },
      automatic_installation = true,
    }
    vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.PATH
  end,
}
