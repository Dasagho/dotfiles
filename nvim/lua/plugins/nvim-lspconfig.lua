return {
    "neovim/nvim-lspconfig",
    opts = {
        inlay_hints = { enabled = false },
        servers = {
            phpactor = {
                cmd = { "phpactor", "language-server" },
                filetypes = { "php" },
                root_dir = function()
                    return vim.loop.cwd()
                end,
                flags = {
                    debounce_text_changes = 250, -- Aumenta este valor para reducir la latencia (250ms recomendado)
                },
                init_options = {
                    ["language_server.diagnostics_on_update"] = false,
                    ["language_server.diagnostics_on_open"] = false,
                    ["language_server.diagnostics_on_save"] = false,
                    ["language_server_phpstan.enabled"] = false,
                    ["language_server_psalm.enabled"] = false,
                }
            },

            lua_ls = {
                settings = {
                    Lua = {
                        runtime = {
                            -- Dile a lua_ls que estás usando LuaJIT (la versión de Lua que Neovim usa)
                            version = 'LuaJIT',
                            path = vim.split(package.path, ';'),
                        },
                        diagnostics = {
                            -- Reconoce la variable `vim` como global en el entorno de Neovim
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Asegúrate de que el servidor reconozca tu configuración de Neovim
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,  -- Desactiva advertencias innecesarias
                        },
                        telemetry = {
                            enable = false,  -- Desactiva la recopilación de datos de telemetría
                        },
                    },
                }
            },
            html = {},
            cssls = {},
            clangd = {},
            tsserver = {
                root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
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
            },
        },

        setup = {
            tsserver = function(_, opts)
                require('lspconfig').tsserver.setup(opts)
            end,
        },
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = false,  -- Desactiva el texto en línea para errores y advertencias
            signs = true,          -- Desactiva las señales en el lateral
            underline = false,     -- Desactiva el subrayado de errores y advertencias
        })

        -- Use LspAttach autocommand to only map the following keys
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover" })
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
            end,
        })
    end,
}
