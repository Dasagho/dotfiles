-- Requiere los módulos necesarios
local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

-- Configura nvim-dap-ui para que se abra automáticamente cuando comience una sesión de depuración
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


