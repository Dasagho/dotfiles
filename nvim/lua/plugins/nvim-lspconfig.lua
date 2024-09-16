return {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        local lspconfig = require('lspconfig')

        vim.diagnostic.config({
            virtual_text = false, -- Desactiva el texto en línea para errores y advertencias
            signs = true, -- Activa las señales en el lateral
            underline = false, -- Desactiva el subrayado de errores y advertencias
        })

        -- Lista de servidores que se configurarán automáticamente
        local servers = { "html", "cssls", "clangd", "gopls", "angularls" }

        -- Función para configurar los servidores LSP
        for _, server in ipairs(servers) do
            lspconfig[server].setup({})
        end

        -- Configuración personalizada de ts_ls
        lspconfig.ts_ls.setup({
            root_dir = lspconfig.util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
            single_file_support = false,
            settings = {
                typescript = {
                    preferences = {
                        importModuleSpecifier = "non-relative",
                        includePackageJsonAutoImports = "on",
                    },
                },
                javascript = {
                    preferences = {
                        importModuleSpecifier = "non-relative",
                        includePackageJsonAutoImports = "on",
                    },
                },
            },
            init_options = {
                preferences = {
                    jsxAttributeCompletionStyle = "braces" -- Habilitar autocompletado de JSX
                }
            },
        })

        lspconfig.phpactor.setup({
            cmd = { "phpactor", "language-server" },
            filetypes = { "php" },
            root_dir = function()
                return require('lspconfig.util').root_pattern('composer.json', '.git')(vim.fn.getcwd()) or vim.loop.cwd()
            end,
            flags = {
                debounce_text_changes = 500,
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

        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',    -- Versión usada por Neovim
                        path = vim.split(package.path, ';'),
                    },
                    diagnostics = {
                        globals = { 'vim' },   -- Reconoce la variable global `vim`
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- Para que reconozca los archivos de configuración de Neovim
                        checkThirdParty = false, -- Desactiva la advertencia de terceros
                    },
                    telemetry = {
                        enable = false,        -- Desactiva la telemetría si lo prefieres
                    },
                },
            },
        }

        lspconfig.emmet_ls.setup {
            filetypes = { 'html', 'css', 'php' },
        }
    end,
}
