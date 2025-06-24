local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  ts_ls = {},
  html = {},
  cssls = {},
  jsonls = {},
  marksman = {},
  dockerls = {},
  docker_compose_language_service = {},
  sqls = {},
  yamlls = {},
  bashls = {},
  emmet_ls = {},
  phpactor = {},
  lua_ls = {
    settings = {
      Lua = { completion = { callSnippet = 'Replace' } },
    },
  },
}

local formatters = { 'prettierd', 'stylua', 'black', 'isort' }
local linters = { 'eslint_d' }

-- single authoritative list for mason-tool-installer *and* mason-lspconfig
local ensure = vim.tbl_flatten { vim.tbl_keys(servers), formatters, linters }

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },

  dependencies = {
    { 'williamboman/mason.nvim', config = true, lazy = false },
    'williamboman/mason-lspconfig.nvim',
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      lazy = false,
      dependencies = 'williamboman/mason-lspconfig.nvim',
      opts = {
        ensure_installed = ensure,
        start_delay = 3000,
        run_on_start = true,
        debounce_hours = 24,
      },
    },
    -- swap for cmp_nvim_lsp if you prefer
    'saghen/blink.cmp',
  },

  config = function()
    ---------------------------------------------------------------------------
    --  Capabilities (cmp → lsp) ----------------------------------------------
    ---------------------------------------------------------------------------
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    ---------------------------------------------------------------------------
    --  LSP server startup ----------------------------------------------------
    ---------------------------------------------------------------------------
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers),
      handlers = {
        function(server)
          local opts = vim.tbl_deep_extend('force', { capabilities = capabilities }, servers[server] or {})
          require('lspconfig')[server].setup(opts)
        end,
      },
    }

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
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf })
          end, 'toggle inlay hints')
        end
      end,
    })

    ---------------------------------------------------------------------------
    --  Diagnostics UI --------------------------------------------------------
    ---------------------------------------------------------------------------
    vim.diagnostic.config {
      severity_sort = true,
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and true or false,
      virtual_text = { spacing = 2, source = 'if_many' },
      float = { border = 'rounded', source = 'if_many' },
    }
  end,
}
