-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},  -- Para snippets
    },
    config = function()
        local lsp = require('lsp-zero')

        -- Lista de servidores que estás usando
        local servers = { 'ts_ls', 'intelephense', 'clangd', 'emmet_ls' } -- agrega los servidores que necesites

        -- Configura cada servidor con las capacidades modificadas
        for _, server in ipairs(servers) do
            lsp.configure(server, {
                -- Aquí puedes agregar otras configuraciones específicas del servidor si lo deseas
            })
        end

        -- Configuraciones específicas de servidores
        lsp.configure('ts_ls', {
            root_dir = require('lspconfig').util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
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
                    jsxAttributeCompletionStyle = "braces" -- Autocompletado JSX
                }
            }
        })

        lsp.configure('intelephense', {
            settings = {
                intelephense = {
                    files = {
                        maxSize = 5000000, -- 5MB como máximo
                    },
                },
            },
        })

          lsp.configure('jdtls', { })

        -- Configurar EFM (aún sin PHP_CodeSniffer y PHP-CS-Fixer)
        -- lsp.configure('efm', {
        --     init_options = { documentFormatting = true },
        --     settings = {
        --         rootMarkers = {".git/"},
        --         languages = {
        --             php = {}, -- Añadir linters o formateadores más tarde
        --         },
        --     }
        -- })

        -- lsp.configure('phpactor', {
        --     cmd = { "phpactor", "language-server" },
        --     filetypes = { "php" },
        --     root_dir = function()
        --         return require('lspconfig').util.root_pattern('composer.json', '.git')(vim.fn.getcwd()) or vim.loop.cwd()
        --     end,
        --     flags = {
        --         debounce_text_changes = 500,
        --     },
        --     init_options = {
        --         ["language_server_phpstan.enabled"] = false,
        --         ["language_server_psalm.enabled"] = false,
        --     },
        --     on_attach = function(client)
        --         client.config.settings.phpactor = client.config.settings.phpactor or {}
        --         client.config.settings.phpactor.classLoader = vim.fn.getcwd() .. "/vendor/autoload.php"
        --     end
        -- })

        lsp.configure('lua_ls', {
            on_attach = function (client)
                client.server_capabilities.document_formatting = true
            end,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',    -- Versión usada por Neovim
                    },
                    diagnostics = {
                        globals = { 'vim' },   -- Reconoce la variable global `vim`
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- Archivos de Neovim
                        checkThirdParty = false, -- Desactiva la advertencia de terceros
                    },
                    telemetry = {
                        enable = false,        -- Desactiva la telemetría
                    },
                }
            }
        })

        lsp.configure('clangd', {})

        lsp.configure('emmet_ls', {
            filetypes = { 'html', 'css', 'php' }
        })

        vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(
            vim.lsp.handlers.codeAction, {
                signs = false
            }
        )

        -- Configurar los diagnósticos
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            underline = false,
            severity_sort = false,
            float = false,
        })

        local signs = { Error = "E", Warn = "W", Hint = " ", Info = "I" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        lsp.setup({
            manage_nvim_cmp = true, -- Maneja la configuración de autocompletado
            set_lsp_keymaps = true, -- Activa los keymaps por defecto
            on_attach = function(client, bufnr)
                -- Aquí puedes añadir configuraciones adicionales que se aplicarán a todos los servidores
                vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(
                    vim.lsp.handlers.codeAction, 
                    { signs = false }
                )
            end
        })

    end
}
