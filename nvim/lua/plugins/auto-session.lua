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
            auto_session_enable_last_session = false,
            bypass_save_filetypes = { 'alpha', 'dashboard' }, -- or whatever dashboard you use
            pre_save_cmds = {
                "tabdo Neotree close" -- Close NERDTree before saving session
            },
            auto_session_suppress_dirs = {
                '~/',
                '~/Downloads',
                '/'
            }
        })
    end
}
