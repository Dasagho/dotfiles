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
        -- 'python', -- Python
        'js', -- JavaScript
        -- 'delve', -- Go
        'codelldb', -- C / C++
      },
    }

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

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = { vim.fn.stdpath 'data' .. '/mason' .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    require('dap.ext.vscode').load_launchjs(nil, {
      python = { 'python' },
      ['pwa-node'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      delve = { 'go' },
      codelldb = { 'c', 'cpp' },
    })

    local map = vim.keymap.set
    map('n', '<leader>dc', require('dap').continue, { desc = 'DAP: Continue/Start' })
    map('n', '<leader>dn', require('dap').step_over, { desc = 'DAP: Step Over' })
    map('n', '<leader>di', require('dap').step_into, { desc = 'DAP: Step Into' })
    map('n', '<leader>do', require('dap').step_out, { desc = 'DAP: Step Out' })

    map('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
    map('n', '<leader>dB', function()
      require('dap').set_breakpoint(vim.fn.input 'Condition: ')
    end, { desc = 'DAP: Conditional Breakpoint' })

    map('n', '<leader>dr', require('dap').repl.open, { desc = 'DAP: Open REPL' })
    map('n', '<leader>du', require('dapui').toggle, { desc = 'DAP: Toggle UI' })
    map('n', '<leader>dl', require('telescope').extensions.dap.list_breakpoints, { desc = 'DAP: List Breakpoints' })

    map('n', '<leader>dq', require('dap').terminate, { desc = 'DAP: Terminate Session' })
  end,
}
