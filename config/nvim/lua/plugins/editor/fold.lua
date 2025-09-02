---@type LazyPluginSpec
return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { -- must have these
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufReadPost',
    opts = {
      -- Use Treesitter for JSX/TSX, fallback to indent for odd files
      provider_selector = function(_, filetype)
        if filetype == 'javascriptreact' or filetype == 'typescriptreact' then
          return { 'treesitter', 'indent' }
        end
        return { 'lsp', 'indent' }
      end,
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        -- fallback when no explicit file-type match
        default = { 'imports', 'comment' },

        -- examples of fine-grained control
        javascriptreact = { 'imports', 'comment', 'region' },
        typescriptreact = { 'imports', 'comment', 'region' },
        json = { 'array' }, -- collapse huge arrays
        c = { 'comment', 'region' }, -- keep pre-processor open
      },
    },
    init = function()
      -- Required globals
      vim.o.foldlevel = 99 -- using UFO needs a high start level
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        desc = 'Open all folds',
      },

      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        desc = 'Close all folds',
      },

      {
        'zr',
        function()
          require('ufo').openFoldsExceptKinds()
        end,
        desc = 'Open folds except imports/comment',
      },

      {
        'zm',
        function()
          require('ufo').closeFoldsWith()
        end,
        desc = 'Reduce fold level',
      },

      {
        'zp',
        function()
          require('ufo').peekFoldedLinesUnderCursor()
        end,
        desc = 'Peek folded lines',
      },

      {
        'K',
        function()
          local win = require('ufo').peekFoldedLinesUnderCursor()
          if not win then
            vim.lsp.buf.hover()
          end
        end,
        desc = 'Peek fold or LSP hover',
      },
    },
  },
}
