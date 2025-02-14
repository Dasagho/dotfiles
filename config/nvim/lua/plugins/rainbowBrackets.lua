return {
  {
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Carga el plugin al abrir o crear un buffer
    config = function()
      -- Configuración opcional del plugin
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          -- 'RainbowDelimiterGreen',
          -- 'RainbowDelimiterViolet',
          -- 'RainbowDelimiterCyan',
        },
      }
    end,
  },
}
