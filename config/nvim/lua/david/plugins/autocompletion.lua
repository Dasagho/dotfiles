return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',

    -- LazyDev integration
    'folke/lazydev.nvim',

    -- Optional: Nice icons
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    -- Configure luasnip to be less aggressive
    luasnip.config.setup {
      -- Don't show snippets for single characters or very short text
      store_selection_keys = '<Tab>',
      -- Disable automatic snippet expansion
      enable_autosnippets = false,
      -- Be more selective about when to show snippets
      update_events = { 'TextChanged', 'TextChangedI' },
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noselect', -- Don't auto-select first item
      },
      mapping = cmp.mapping.preset.insert {
        -- VSCode-like behavior: Arrow keys to navigate
        ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },

        -- Keep Ctrl+n/p as alternatives
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- ESC to close completion menu
        ['<C-e>'] = cmp.mapping.abort(),

        -- VSCode-like Tab behavior: Accept first item or selected item
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- If nothing is selected, select the first item, otherwise confirm selection
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              cmp.confirm()
            end
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Shift+Tab for snippet jumping or previous item
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Enter to confirm only if explicitly selected (more VSCode-like)
        ['<CR>'] = cmp.mapping {
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm { select = true },
          c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        },

        -- Manually trigger a completion from nvim-cmp.
        ['<C-Space>'] = cmp.mapping.complete {},
      },

      -- Sources for autocompletion (in order of priority)
      sources = cmp.config.sources({
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'path' },
      }, {
        {
          name = 'luasnip',
          keyword_length = 3, -- Only show snippets after 3+ characters
          max_item_count = 5, -- Limit snippet suggestions
          entry_filter = function(entry, ctx)
            -- Don't show snippets that are just the exact text typed
            local typed_text = string.sub(ctx.cursor_before_line, ctx.cursor.col - ctx.offset)
            return entry.completion_item.label ~= typed_text
          end,
        },
        { name = 'buffer' },
      }),

      -- Optional: Configure the appearance
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function(entry, vim_item)
            -- Show source name
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
              lazydev = '[LazyDev]',
            })[entry.source.name]
            return vim_item
          end,
        },
      },

      -- Enable ghost text (similar to your blink config)
      experimental = {
        ghost_text = vim.g.ai_cmp and true or false,
      },

      -- Window styling (optional)
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    }

    cmp.setup.filetype({ 'typescriptreact' }, {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
        -- Note: no luasnip here for these filetypes
      }),
    })
  end,
}
