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

        require("mason-lspconfig").setup_handlers({
            function (server_name) -- Default handler
                require("lspconfig")[server_name].setup {
                    flags = {
                        debounce_text_changes = 250, -- Debounce para reducir latencia
                    },
                    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
                }
            end,
        })

        vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
    end
}
