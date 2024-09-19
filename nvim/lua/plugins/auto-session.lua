return {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = {
            '~/',
            '~/Downloads',
            '/'
        },
        -- log_level = 'debug',
    },
    config = function ()
        require('auto-session').setup({
            bypass_save_filetypes = { 'alpha', 'dashboard' }, -- or whatever dashboard you use
            pre_save_cmds = {
                "tabdo Neotree close" -- Close NERDTree before saving session
            },
        })
    end
}
