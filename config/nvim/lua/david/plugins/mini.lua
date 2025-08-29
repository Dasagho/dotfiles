---@type LazyPluginSpec
return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.surround').setup {
      -- The defaults are deliberately different from vim-surround.
      -- Change them here if muscle memory expects "ys", "ds", "cs"…
      mappings = {
        add = 'sa', -- add surrounding       e.g.  saiw"
        delete = 'sd', -- delete surrounding    e.g.  sdt"
        replace = 'sr', -- replace surrounding   e.g.  sr)"'
        find = 'sf', -- find to the right     e.g.  sf)
        find_left = 'sF', -- find to the left
        highlight = 'sh', -- highlight surrounding
        update_n_lines = 'sn', -- set n_lines for next command
      },
    }
  end,
}
