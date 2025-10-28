---@type LazyPluginSpec[]
return {
  ---------------------------------------------------------------------------
  -- 1) Noice: modern messages/cmdline/LSP UI, routed to nvim-notify
  ---------------------------------------------------------------------------
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-notify',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      -- Keep Noice for docs/cmdline, but stop it from emitting LSP progress
      lsp = {
        progress = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      -- Route notifications to the notify view, merge duplicates
      notify = {
        enabled = true,
        view = 'notify',
        merge = true,
      },

      -- Keep the handy presets, but nothing fancy
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },

      -- Views: make notify compact and short-lived
      views = {
        notify = {
          replace = true,
          win_options = { winblend = 10 },
          timeout = 1200,
          max_width = 60,
          max_height = 8,
        },
      },

      -- Kill the most common noise sources
      routes = {
        -- Generic “no info” / benign LSP messages
        { filter = { event = 'notify', find = 'No information available' }, opts = { skip = true } },
        { filter = { event = 'notify', find = 'formatting' }, opts = { skip = true } },
        -- Write/undo/search spam from Neovim core
        { filter = { event = 'msg_show', find = 'written' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'fewer lines' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'more lines' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'Already at' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'E486: Pattern not found' }, opts = { skip = true } },
        { filter = { event = 'msg_show', kind = 'search_count' }, opts = { skip = true } },
        -- LSP progress duplicates (defensive)
        { filter = { event = 'lsp', kind = 'progress' }, opts = { skip = true } },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- 2) Fidget: minimal, unobtrusive LSP progress (starts only on attach)
  ---------------------------------------------------------------------------
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      progress = {
        poll_rate = 120,
        suppress_on_insert = true,
        display = {
          -- Use a built-in, name-based pattern to avoid encoding issues
          progress_icon = { pattern = 'dots' }, -- safe preset
          done_icon = 'OK', -- plain ASCII
        },
      },
      notification = {
        override_vim_notify = false,
      },
    },
  },

  ---------------------------------------------------------------------------
  -- 3) nvim-notify: quiet backend with compact visuals
  ---------------------------------------------------------------------------
  {
    'rcarriga/nvim-notify',
    lazy = true, -- loaded via Noice
    opts = {
      stages = 'fade_in_slide_out',
      timeout = 1200,
      top_down = false,
      render = 'compact',
      max_width = 60,
      max_height = 8,
      background_colour = '#000000',
    },
    -- Do NOT set vim.notify here; Noice handles routing.
  },
}
