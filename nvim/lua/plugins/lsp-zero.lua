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

        lsp.setup({
            manage_nvim_cmp = true, -- Maneja la configuración de autocompletado
            set_lsp_keymaps = true, -- Activa los keymaps por defecto
        })

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

        -- Configurar EFM (aún sin PHP_CodeSniffer y PHP-CS-Fixer)
        lsp.configure('efm', {
            init_options = { documentFormatting = true },
            settings = {
                rootMarkers = {".git/"},
                languages = {
                    php = {}, -- Añadir linters o formateadores más tarde
                },
            }
        })

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

        lsp.configure('emmet_ls', {
            filetypes = { 'html', 'css', 'php' }
        })

        -- Desactivar texto virtual, signos y subrayado para diagnósticos
        vim.diagnostic.config({
            virtual_text = false, -- No mostrar texto en línea para errores/advertencias
            signs = true,         -- Mantener las señales en el lateral
            underline = false,    -- Desactivar subrayado
        })

        -- Inicializar LSP con las configuraciones
        lsp.setup()
    end
}
