return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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

                vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "go to declaration" })
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "go to definition" })
                vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover" })
                vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "go to implementation" })
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "signature help" })
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc ="add workspace folder" })
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "remove workspace folder" })
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = ev.buf, desc = "list workspace folders" })
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "type definition" })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "references" })
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            },
        }
        -- Setup language servers.
        local lspconfig = require "lspconfig"

        lspconfig.lua_ls.setup {}

        -- setup multiple servers with same default options
        local servers = { "ts_ls", "html", "cssls", "clangd" }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                capabilities = capabilities,
            }
        end

    end,
}
