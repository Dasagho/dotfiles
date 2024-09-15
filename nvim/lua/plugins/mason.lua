return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    cmd = { "Mason", "MasonInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
        ensure_installed = {
            "lua-language-server",
            "typescript-language-server",
            "docker-compose-language-service",
            "dockerfile-language-server",
            "css-lsp",
            "html-lsp",
            "json-lsp",
            "marksman",
        },
    },
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "phpactor" },
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
