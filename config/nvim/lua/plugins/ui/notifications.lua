---@type LazyPluginSpec[]
-- Unified notifications & LSP progress: Noice (UI) + Fidget (spinners) + nvim-notify (backend)

return {
  ---------------------------------------------------------------------------
  -- 1) Modern messages / cmdline / LSP UI (uses nvim-notify as backend)
  ---------------------------------------------------------------------------
  {
    'folke/noice.nvim',
    event = 'VeryLazy', -- load early enough to catch UI/cmdline, but after startup
    dependencies = {
      'rcarriga/nvim-notify',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      -- Hand LSP progress to Fidget → avoid duplicate spinners
      lsp = {
        progress = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      -- Notifications: render via the "notify" view (nvim-notify look/feel)
      notify = {
        enabled = true,
        view = 'notify',
        merge = true, -- merge identical messages
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },

      -- Example: silence noisy LSP info
      routes = {
        {
          filter = { event = 'notify', find = 'No information available' },
          opts = { skip = true },
        },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- 2) LSP progress HUD / spinners (no notify override)
  ---------------------------------------------------------------------------
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach', -- start when an LSP actually attaches
    opts = {
      progress = {
        poll_rate = 120,
        suppress_on_insert = true,
        display = {
          -- keep schema simple & compatible
          progress_icon = { 'dots' },
          done_icon = '',
        },
      },
      notification = {
        override_vim_notify = false, -- Noice owns vim.notify path
      },
    },
  },

  ---------------------------------------------------------------------------
  -- 3) Notify backend (used by Noice's notify view)
  ---------------------------------------------------------------------------
  {
    'rcarriga/nvim-notify',
    lazy = true, -- pulled in by Noice dependency
    opts = {
      stages = 'fade_in_slide_out',
      timeout = 1000,
      top_down = false,
      render = 'default',
    },
    -- NOTE: Do NOT set `vim.notify = require("notify")` here.
    -- We let Noice route notifications to this backend.
  },
}
