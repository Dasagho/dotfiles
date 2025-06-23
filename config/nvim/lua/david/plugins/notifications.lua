-- Combines folke/noice.nvim and j-hui/fidget.nvim into a fault‑free, unified
-- notification stack. Drop this file into your Lazy.nvim spec directory
-- (e.g. ~/.config/nvim/lua/plugins) and restart Neovim.

return {
  ---------------------------------------------------------------------------
  -- 1️⃣  Modern message & notification UI -----------------------------------
  ---------------------------------------------------------------------------
  {
    'folke/noice.nvim',
    event = 'VeryLazy', -- Load after the UI is ready
    dependencies = {
      'rcarriga/nvim-notify',
      'MunifTanjim/nui.nvim', -- Required UI toolkit
    },
    opts = {
      -- Hand LSP progress to Fidget → no duplicate spinners
      lsp = {
        progress = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      -- Notifications: use Noice’s built‑in “notify” view (nvim‑notify look‑alike)
      notify = {
        enabled = true,
        view = 'notify', -- slide‑in float with icons & stages
        throttle = 1000, -- merge identical msgs within 1s
        merge = true,
      },

      -- Helpful UI presets
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },

      -- Example route: silence the common LSP “No information available” spam
      routes = {
        {
          filter = { event = 'notify', find = 'No information available' },
          opts = { skip = true },
        },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- 2️⃣  LSP progress HUD & notify bridge ----------------------------------
  ---------------------------------------------------------------------------
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach', -- Spin up when the first LSP connects
    opts = {
      -- Progress spinners ---------------------------------------------------
      progress = {
        poll_rate = 120, -- ms between updates
        suppress_on_insert = true, -- hide while typing
        display = {
          progress_icon = { pattern = 'dots', period = 1 }, -- fallback to core CLI spinner,
          done_icon = '', -- Nerd‑font checkmark
        },
      },

      -- Notifications -------------------------------------------------------
      notification = {
        override_vim_notify = false, -- Noice already owns vim.notify
      },
    },
  },
}
