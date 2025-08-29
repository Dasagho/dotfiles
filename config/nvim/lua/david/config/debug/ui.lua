local M = {}

function M.setup()
  local ok, dapui = pcall(require, 'dapui')
  if not ok then
    return
  end

  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '▶' },

    mappings = {
      expand = { '<CR>', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      edit = 'e',
      repl = 'r',
      toggle = 't',
    },

    element_mappings = {
      stacks = { open = 'o' },
      scopes = { open = 'o' },
      watches = { open = 'o' },
      breakpoints = { open = 'o' },
      repl = { open = 'o' },
    },

    controls = {
      enabled = true,
      element = 'repl', -- which element the controls appear in
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '↲',
        step_over = '⤼',
        step_out = '⤱',
        step_back = 'b', -- required
        run_last = '▶▶', -- required
        terminate = '⏹',
        disconnect = '✖',
      },
    },

    expand_lines = false, -- let treesitter handle line expansion if you want true/false
    force_buffers = true, -- keeps elements in buffers rather than ephemeral windows

    layouts = {
      {
        elements = {
          { id = 'scopes', size = 0.25 },
          { id = 'watches', size = 0.25 },
          { id = 'breakpoints', size = 0.25 },
          { id = 'stacks', size = 0.25 },
        },
        size = 60,
        position = 'left',
      },
      {
        elements = {
          { id = 'repl', size = 0.50 },
          { id = 'watches', size = 0.50 },
        },
        size = 10,
        position = 'bottom',
      },
    },

    floating = {
      max_height = nil, -- set to number to clamp
      max_width = nil, -- set to number to clamp
      border = 'single',
      mappings = { close = { 'q', '<Esc>' } },
    },

    render = {
      indent = 1,
      max_type_length = nil, -- truncate long type annotations if desired
    },
  }

  -- lifecycle listeners (unchanged)
  local dap = require 'dap'
  dap.listeners.after.event_initialized['user.dapui'] = function()
    dapui.open { reset = true }
  end
  -- dap.listeners.before.event_terminated['user.dapui'] = function()
  --   dapui.close()
  -- end
  -- dap.listeners.before.event_exited['user.dapui'] = function()
  --   dapui.close()
  -- end
end

return M
