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
}
