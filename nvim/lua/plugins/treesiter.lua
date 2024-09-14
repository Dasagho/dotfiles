return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'catppuccin/nvim' },
    ensure_installed = { "lua", "html", "javascript", "typescript", "css", "tsx", "json" },
    event = { 'BufRead', 'BufNewFile', "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, 
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function ()
        require'nvim-treesitter.configs'.setup {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = { "php" },
            },
            indent = { enable = true },
        }
    end
}
