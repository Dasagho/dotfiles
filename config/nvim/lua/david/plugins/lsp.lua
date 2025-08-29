---@type LazyPluginSpec
return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('david.config.lsp').setup()
      end,
    },
  },

  config = function()
    ---------------------------------------------------------------------------
    --  Key-maps (attach-time) ------------------------------------------------
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true }),
      callback = function(ev)
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = 'LSP: ' .. desc })
        end

        bmap('n', 'gd', vim.lsp.buf.definition, 'definition')
        bmap('n', 'gD', vim.lsp.buf.declaration, 'declaration')
        bmap('n', 'gi', vim.lsp.buf.implementation, 'implementation')
        bmap('n', 'gr', require('telescope.builtin').lsp_references, 'references')
        bmap('n', '<leader>rn', vim.lsp.buf.rename, 'rename symbol')
        bmap({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'code action')
        bmap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, 'document symbols')
        bmap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

        if vim.lsp.inlay_hint then
          bmap('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
          end, 'toggle inlay hints')
        end
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = group,
            buffer = ev.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = group,
            buffer = ev.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
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
