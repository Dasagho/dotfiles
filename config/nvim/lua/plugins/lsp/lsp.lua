---@type LazyPluginSpec
return {
  'neovim/nvim-lspconfig',
  ft = require('config.languages').filetypes_enabled(),
  config = function()
    require('config.lsp').setup()

    ---------------------------------------------------------------------------
    --  Key-maps (attach-time) ------------------------------------------------
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true }),
      callback = function(ev)
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = 'LSP: ' .. desc, silent = true, noremap = true })
        end

        bmap('n', 'gd', vim.lsp.buf.definition, 'definition')
        bmap('n', 'gD', vim.lsp.buf.declaration, 'declaration')
        bmap('n', 'gi', vim.lsp.buf.implementation, 'implementation')
        bmap('n', 'gr', function()
          vim.cmd 'Telescope lsp_references'
        end, 'references')
        bmap('n', '<leader>rn', vim.lsp.buf.rename, 'rename symbol')
        bmap({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'code action')
      end,
    })

    ---------------------------------------------------------------------------
    --  Diagnostics UI --------------------------------------------------------
    ---------------------------------------------------------------------------
    vim.diagnostic.config {
      severity_sort = true,
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = true,
      virtual_text = { spacing = 2, source = 'if_many' },
      float = { border = 'rounded', source = 'if_many' },
    }
  end,
}
