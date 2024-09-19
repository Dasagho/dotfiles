return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    cmd = { "Mason", "MasonInstall" },
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "html",
                "gopls",
                "clangd",
                "emmet_ls",
                "cssls",
                "jsonls",
                "pyright",
                "marksman",
                "phpactor",
                "lua_ls",
                "dockerls",
                "docker_compose_language_service",
            },
            automatic_installation = true,
        })

        vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
    end
}
