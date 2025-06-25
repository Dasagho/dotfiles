return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },

  cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapStepInto', 'DapStepOver', 'DapStepOut', 'DapTerminate', 'DapRestartFrame', 'DapToggleRepl' },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        'python', -- Python
        'js', -- Node / JS & TS
        'delve', -- Go
        'codelldb', -- C / C++
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    require('nvim-dap-virtual-text').setup { commented = true }
    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open { reset = true }
    end
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
      },
    }

    local python = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
    require('dap-python').setup(python)

    require('dap.ext.vscode').load_launchjs(nil, {
      python = { 'python' },
      js = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      delve = { 'go' },
      codelldb = { 'c', 'cpp' },
    })

    local map = vim.keymap.set
    -- Core debug actions
    map('n', '<leader>dc', require('dap').continue, { desc = 'DAP: Continue/Start' })
    map('n', '<leader>dn', require('dap').step_over, { desc = 'DAP: Step Over' })
    map('n', '<leader>di', require('dap').step_into, { desc = 'DAP: Step Into' })
    map('n', '<leader>do', require('dap').step_out, { desc = 'DAP: Step Out' })

    -- Breakpoints & friends
    map('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
    map('n', '<leader>dB', function()
      require('dap').set_breakpoint(vim.fn.input 'Condition: ')
    end, { desc = 'DAP: Conditional Breakpoint' })

    -- REPL / UI helpers
    map('n', '<leader>dr', require('dap').repl.open, { desc = 'DAP: Open REPL' })
    map('n', '<leader>du', require('dapui').toggle, { desc = 'DAP: Toggle UI' })
    map('n', '<leader>dl', require('telescope').extensions.dap.list_breakpoints, { desc = 'DAP: List Breakpoints' })

    -- 🔚 Terminate debug session
    map('n', '<leader>dq', require('dap').terminate, { desc = 'DAP: Terminate Session' })
  end,
}
