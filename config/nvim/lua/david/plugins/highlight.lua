---@type LazyPluginSpec
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    event = { 'BufReadPost', 'BufNewFile' }, -- Carga el plugin al abrir o crear un buffer
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
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  build = ':TSUpdate',
  -- ① only when a real buffer is opened from disk
  event = { 'BufReadPost', 'BufNewFile' },
  -- ② never at startup if Neovim was launched without files
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    require('lazy.core.loader').add_to_rtp(plugin)
    require 'nvim-treesitter.query_predicates'
  end,
  config = function()
    local function ts_disable(lang, buf)
      -- hard stop at 100 KiB
      local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stat and stat.size > 100 * 1024 then
        return true
      end
      -- or at 10 000 lines
      return vim.api.nvim_buf_line_count(buf) > 10000
    end

    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'css',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'tsx',
        'javascript',
        'typescript',
        'go',
        'python',
        'dockerfile',
        'gitignore',
      },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true, disable = ts_disable },
      indent = { enable = true, disable = ts_disable },
      incremental_selection = { enable = false },
      textobjects = { enable = false },
      matchup = { enable = false },
    }
  end,
}
