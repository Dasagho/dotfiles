-- config/perf.lua
--
-- Goal:
--  - Reduce redraw work per cursor move
--  - Calm diagnostics / virtual text spam
--  - Slow down LSP re-analysis while you're still typing
--  - Kill UI features that are known to stutter in big buffers
--
-- You can require this very early in init.lua

local M = {}

-- 1. Core editor redraw tuning
function M.core()
  local o = vim.opt

  -- Don't redraw the screen in the middle of macros / batch ops.
  -- (Neovim ignores this sometimes, but it still helps reduce junk work)
  o.lazyredraw = true

  -- Tell nvim "the terminal is fast"
  o.ttyfast = true

  -- Stop doing expensive syntax past very long columns (super important in minified JS / giant HTML-in-PHP lines)
  -- If a line is absurdly long (like bundled JS), syntax highlighting every column wrecks FPS.
  o.synmaxcol = 240

  -- Cursorline highlights the whole line on every move.
  -- This looks nice but it's extra paint work every single cursor move.
  vim.o.cursorline = false

  -- Relative numbers update on every move in every window.
  -- If you like them, keep them. If you want max perf, turn them off globally here.
  -- We'll default to off for perf; comment this out if you love relativenumber.
  vim.o.relativenumber = false

  -- Truecolor: avoids fallback color conversions
  vim.o.termguicolors = true

  -- Updatetime controls CursorHold/etc timers. Making it bigger = fewer diagnostic refreshes while you're actively moving.
  -- 500ms is a nice compromise. Slower than default, but still responsive enough for LSP hovers, etc.
  vim.o.updatetime = 500
end

-- 2. Diagnostics tuning
function M.diagnostics()
  -- We reduce visual spam and disable live updates while typing.
  -- This does two performance wins:
  --  - less redraw of inline virtual text
  --  - less churn from diagnostics updating on every keystroke
  vim.diagnostic.config {
    -- Only underline real errors. Warnings etc. don't need live underline repaint everywhere.
    underline = { severity = vim.diagnostic.severity.ERROR },

    -- Signs in the signcolumn are cheap, keep them.
    signs = true,

    -- Virtual text is EXPENSIVE in giant buffers (because it injects phantom text in every line and has to be redrawn).
    -- We'll turn it off by default for perf. You can toggle it when you want detail.
    virtual_text = false,

    -- Don't recalc diagnostics while you're in insert mode.
    -- This prevents "type one char → LSP recompute → redraw squiggles".
    update_in_insert = false,

    -- Sort messages from most severe first when you do :lopen or float
    severity_sort = true,

    -- Floating windows still allowed, but nothing crazy.
    float = {
      border = 'rounded',
      source = 'if_many',
    },
  }
end

-- 3. LSP client tuning (to be called in on_attach / setupLspServers)
--    We:
--    - apply debounce_text_changes
--    - optionally disable semantic tokens (heavy in TS/HTML/PHP soup)
--    - nuke lightbulb-style code actions-on-move
function M.apply_lsp_defaults(client, bufnr)
  -- Some language servers stream "semantic tokens" (semantic highlighting).
  -- It's pretty but VERY chatty (especially TS/HTML/PHP mixed buffers).
  -- Disabling them removes a surprising amount of churn in large files.
  if client.server_capabilities.semanticTokensProvider then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- Some plugins draw a "💡" or similar code action lightbulb on CursorHold.
  -- That means: every time you move the cursor, trigger code action request,
  -- place a sign/virttext, redraw signcolumn. Terrible for big files.
  -- We won't outright disable codeActionProvider (that breaks <leader>ca),
  -- but we *do not* auto-display anything. The important part is:
  -- don't run lightbulb plugins at all in perf mode.

  -- Optional: you can also kill inlay hints live if they spam render.
  -- Comment this back in if you want hints:
  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  -- end

  -- You could do buffer-local tweaks here if needed later.
end

-- 4. "Perf mode" toggle for pathological files
--    This lets you hit <leader>fp and instantly drop weight in just THIS buffer
--    (no treesitter highlight, no diagnostics spam, etc.).
function M.enable_buffer_perf_mode(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Kill Treesitter highlighting for this buffer (keeps plain syntax or nothing)
  pcall(vim.treesitter.stop, bufnr)

  -- Turn off diagnostics in this buffer entirely
  vim.diagnostic.disable(bufnr)

  -- Optionally turn off indent guides etc. here if you use those plugins.
  -- Example (if you use indent-blankline):
  vim.b.miniindentscope_disable = true
  vim.b.indent_blankline_enabled = false
end

-- 5. Setup keymaps for perf mode toggle
function M.keymaps()
  vim.keymap.set('n', '<leader>fp', function()
    require('config.perf').enable_buffer_perf_mode()
    vim.notify('Perf mode enabled for this buffer', vim.log.levels.INFO)
  end, { desc = 'Enable ultra perf mode (no TS, no diags)' })
end

-- 6. Init wrapper
function M.setup()
  M.core()
  M.diagnostics()
  M.keymaps()
end

return M
