return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require('lspconfig')

        vim.diagnostic.config({
            virtual_text = false, -- Desactiva el texto en línea para errores y advertencias
            signs = true, -- Activa las señales en el lateral
            underline = false, -- Desactiva el subrayado de errores y advertencias
        })

        -- Usa el autocomando LspAttach para mapear solo las siguientes teclas
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Habilita la finalización desencadenada por <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover" })
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
            end,
        })

        -- Lista de servidores que se configurarán automáticamente
        local servers = { "html", "cssls", "clangd", "lua_ls", "phpactor" }

        -- Función para configurar los servidores LSP
        for _, server in ipairs(servers) do
            lspconfig[server].setup({})
        end

        -- Configuración personalizada de ts_ls
        lspconfig.ts_ls.setup({
            root_dir = function(...)
                return lspconfig.util.root_pattern(".git")(...)
            end,
            single_file_support = false,
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "literal",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            },
        })

        lspconfig.phpactor.setup({
            cmd = { "phpactor", "language-server" },
            filetypes = { "php" },
            root_dir = function()
                return require('lspconfig.util').root_pattern('composer.json', '.git')(vim.fn.getcwd()) or vim.loop.cwd()
            end,
            flags = {
                debounce_text_changes = 250,
            },
            init_options = {
                ["language_server_phpstan.enabled"] = false,
                ["language_server_psalm.enabled"] = false,
            },
            on_attach = function(client)
                client.config.settings.phpactor = client.config.settings.phpactor or {}
                client.config.settings.phpactor.classLoader = vim.fn.getcwd() .. "/vendor/autoload.php"
            end,
        })
    end,
}
