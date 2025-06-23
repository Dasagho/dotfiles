------------------------------------------------
-- 1. MiniPairs: lightning-fast auto-pairs
------------------------------------------------
require('mini.pairs').setup() -- zero-config is already perfect

------------------------------------------------
-- 2. MiniSurround: modern, lua-fast surround
------------------------------------------------
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
  -- other options are all great out-of-the-box
} -- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
-- local statusline = require 'mini.statusline'
-- -- set use_icons to true if you have a Nerd Font
-- statusline.setup { use_icons = vim.g.have_nerd_font }
--
-- -- You can configure sections in the statusline by overriding their
-- -- default behavior. For example, here we set the section for
-- -- cursor location to LINE:COLUMN
-- ---@diagnostic disable-next-line: duplicate-set-field
-- statusline.section_location = function()
--   return '%2l:%-2v'
-- end

-- ... and there is more!
--  Check out: https://github.com/echasnovski/mini.nvim
