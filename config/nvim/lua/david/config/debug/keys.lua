local M = {}

function M.setup()
  local dap = require 'dap'
  local dapui = require 'dapui'
  local map = vim.keymap.set

  map('n', '<F5>', function()
    dap.continue()
  end, { desc = 'DAP: Continue' })

  map('n', '<F9>', function()
    dap.toggle_breakpoint()
  end, { desc = 'DAP: Toggle breakpoint' })

  map('n', '<leader>db', function()
    vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(input)
      if not input or input == '' then
        return
      end
      dap.set_breakpoint(input)
      print('Set conditional breakpoint: ' .. input)
    end)
  end, { desc = 'DAP: Set conditional breakpoint' })

  map('n', '<F10>', function()
    dap.step_over()
  end, { desc = 'DAP: Step over' })

  map('n', '<F11>', function()
    dap.step_into()
  end, { desc = 'DAP: Step into' })

  map('n', '<F12>', function()
    dap.step_out()
  end, { desc = 'DAP: Step out' })

  map('n', '<leader>du', function()
    dapui.toggle()
  end, { desc = 'DAP UI: toggle' })

  map('n', '<leader>de', function()
    require('dapui').eval()
  end, { desc = 'DAP UI: eval (cursor)' })

  map('v', '<leader>de', function()
    require('dapui').eval()
  end, { desc = 'DAP UI: eval (visual)' })

  map('n', '<leader>dw', function()
    vim.ui.input({ prompt = 'Watch expr: ', default = vim.fn.expand '<cword>' }, function(input)
      if not input or input == '' then
        return
      end
      -- quick popup evaluation (not a persistent watch)
      require('dapui').eval(input)
      print('Quick-evaluated: ' .. input .. ' (to add permanently: open watches panel and press i)')
    end)
  end, { desc = 'DAP: prompt and quick-eval (suggests adding to watches)' })
end

return M
