---@type LazyPluginSpec
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'folke/lazydev.nvim',
    'onsails/lspkind.nvim',
    -- ↓ push _private names down (VS Code-like feel)
    'lukas-reineke/cmp-under-comparator',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}

    -- VS Code-ish sorting:
    -- exact prefix → LSP score → _under_ last → recently used → locality → kind → sortText → length → order
    local comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require('cmp-under-comparator').under,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    }

    -- Optional: set to true to mimic `"editor.snippetSuggestions": "top"`
    local SNIPPETS_TOP = false
    if SNIPPETS_TOP then
      table.insert(comparators, 1, function(entry1, entry2)
        local s = cmp.lsp.CompletionItemKind.Snippet
        local k1, k2 = entry1:get_kind(), entry2:get_kind()
        if k1 == s and k2 ~= s then
          return true
        end
        if k2 == s and k1 ~= s then
          return false
        end
      end)
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { select = false },
        ['<C-e>'] = cmp.mapping.abort(),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'lazydev' },
      },
      sorting = {
        priority_weight = 2, -- give LSP a bit more weight like VS Code
        comparators = comparators,
      },
      formatting = {
        format = require('lspkind').cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '…', -- fix mojibake
        },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true, -- VS Code-like inline ghost text (optional)
      },
    }
  end,
}
