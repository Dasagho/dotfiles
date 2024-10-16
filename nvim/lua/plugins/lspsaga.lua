return {
    'nvimdev/lspsaga.nvim',
    config = function ()
        require('lspsaga').setup({
            lightbulb = {
                enable = false,
                sign = false,
                virtual_text = false,
            },
            server_filetype_map = {
                typescript = 'typescript'
            }
        })

        vim.keymap.set('n', '<leader>cj', '<Cmd>Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true, desc = "next error" })
        vim.keymap.set('n', '<leader>ck', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', { noremap = true, silent = true, desc = "prev error" })
        vim.keymap.set('n', '<leader>k', '<Cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true, desc = "hover" })
        vim.keymap.set('n', '<leader>cr', '<Cmd>Lspsaga rename<CR>', { noremap = true, silent = true, desc = "rename" })
        vim.keymap.set('n', '<leader>cd', '<Cmd>Lspsaga show_buf_diagnostics<CR>', { noremap = true, silent = true, desc = "diagnostics" })
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = "Code actions" })
    end
}
