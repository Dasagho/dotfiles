---@type LazyPluginSpec
return {
  'goolord/alpha-nvim',
  lazy = false, -- load immediately at startup
  priority = 1000, -- make sure it wins the splash screen race
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Runtime configuration for Alpha-nvim.
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- ╭─ Header ───────────────────────────────────────╮
    dashboard.section.header.val = {
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
    }

    local config_dir = vim.fn.stdpath 'config'
    local config_file = config_dir .. '/init.lua'

    vim.api.nvim_create_autocmd('BufLeave', {
      pattern = 'alpha',
      callback = function()
        vim.cmd 'doautocmd User AlphaClosed'
      end,
    })

    vim.api.nvim_create_autocmd('BufLeave', {
      pattern = 'alpha',
      callback = function()
        vim.cmd 'bd' -- Cierra el buffer de Alpha.nvim
      end,
    })

    dashboard.section.buttons.val = {
      -- File actions --------------------------------------------------------------
      dashboard.button('e', '  New file', ':ene <CR>'),
      dashboard.button('f', '󰈞  Find file', ':Telescope find_files<CR>'),
      dashboard.button('g', '󰈬  Live grep', ':Telescope live_grep<CR>'),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),

      -- Toolbox (built-ins only) --------------------------------------------------
      dashboard.button('c', '  Edit config', ':cd ' .. config_dir .. ' | e ' .. config_file .. ' <CR>'),
      dashboard.button('l', '󰒲  Lazy home', ':Lazy<CR>'),
      dashboard.button('u', '󰏖  Update plugins', ':Lazy sync<CR>'),

      -- Exit ----------------------------------------------------------------------
      dashboard.button('q', '󰅚  Quit', ':qa<CR>'),
    }

    -- Optional: highlight tweaks
    dashboard.section.header.opts.hl = 'Type'
    dashboard.section.buttons.opts.hl = 'Keyword'

    alpha.setup(dashboard.opts) -- initialise
  end,
}
