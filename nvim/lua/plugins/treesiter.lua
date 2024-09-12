return {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    ensure_installed = { "lua", "html", "javascript", "typescript", "css", "tsx", "json" },

    config = function ()
        require'nvim-treesitter.configs'.setup {
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            indent = { enable = true },
        }
    end
}
