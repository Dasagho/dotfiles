return {
    'kndndrj/nvim-dbee',
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        require("dbee").install()
    end,

    config = function()
        local sources = require('dbee.sources')
        vim.keymap.set('n', '<leader>dd', '<cmd>Dbee toggle<CR>', { noremap = true, silent = true, desc = "open database" })
        require("dbee").setup({
            sources = {
                sources.MemorySource:new({
                    {
                        id = "1",
                        name = "dialapplet",
                        type = "postgresql",
                        url = "postgresql://localhost/dialapplet?user=dialapplet&password=123456&sslmode=disable",
                    },
                    {
                        id = "2",
                        name = "report",
                        type = "postgresql",
                        url = "postgresql://localhost/report?user=report&password=report&sslmode=disable",
                    }
                })
            }
        })
    end,
}
