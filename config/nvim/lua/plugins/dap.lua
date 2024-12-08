return {
  "mfussenegger/nvim-dap",
  cmd = { "DapToggleBreakpoint", "DapContinue", "DapStepOver" },
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      dependencies = { "nvim-neotest/nvim-nio" },
      keys = {
        {
          "<leader>du",
          function()
            require("dapui").toggle {}
          end,
          desc = "Dap UI",
        },
        {
          "<leader>de",
          function()
            require("dapui").eval()
          end,
          desc = "Eval",
          mode = { "n", "v" },
        },
      },
      config = function()
        local dapui = require "dapui"
        dapui.setup {}
      end,
    },
  },
  keys = {
    { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      desc = "Breakpoint Condition",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>da",
      function()
        require("dap").continue { before = get_args }
      end,
      desc = "Run with Args",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dg",
      function()
        require("dap").goto_()
      end,
      desc = "Go to Line (No Execute)",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>dp",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
  },

  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    local icons = {
      Breakpoint = { "🟥", "DiagnosticError" },
      BreakpointCondition = { "🟨", "DiagnosticWarn" },
      LogPoint = { "🔵", "DiagnosticInfo" },
      Stopped = { "🟢", "DiagnosticHint" },
    }
    -- Asignar los iconos a los diferentes estados de dap
    for name, sign in pairs(icons) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    local vscode = require "dap.ext.vscode"
    local json = require "plenary.json"
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end

    -- Extends dap.configurations with entries read from .vscode/launch.json
    if vim.fn.filereadable ".vscode/launch.json" then
      vscode.load_launchjs(nil)
    end

    local dap = require "dap"

    dap.listeners.after["event_terminated"]["print_stderr"] = function(session, body)
      if session.adapter and session.adapter.stdio then
        local stderr_output = session.adapter.stdio[2]:read "*a" -- lee la salida de stderr
        if stderr_output and #stderr_output > 0 then
          print("Error en el adaptador:", stderr_output)
        end
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function()
        require("dap.ext.autocompl").attach()
      end,
    })

    -- local function load_launchjs()
    --     require("dap.ext.vscode").load_launchjs(nil, {
    --         -- Mapea los tipos de adaptadores DAP a las extensiones de archivo
    --         ["pwa-node"] = { "javascript", "typescript" },
    --         ["cppdbg"] = { "c", "cpp" },
    --         ["python"] = { "python" },
    --         -- Agrega más mapeos según sea necesario
    --     })
    -- end
    --
    -- vim.api.nvim_create_autocmd("DirChanged", {
    --     callback = load_launchjs,
    -- })
    --
    -- load_launchjs() -- Carga inicial
  end,
}
