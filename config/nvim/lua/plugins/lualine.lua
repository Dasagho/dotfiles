return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "arkav/lualine-lsp-progress", opt = true },
    { "mfussenegger/nvim-lint",     lazy = true },
  },
  event = "User AlphaClosed",
  config = function()
    local lsp_value = ""
    local formatter_value = ""
    local dap_value = ""
    local linter_value = ""

    local function update_lsp_clients()
      local clients = vim.lsp.get_active_clients { bufnr = 0 }
      if #clients == 0 then
        lsp_value = ""
        return
      end

      local client_names = {}
      for _, client in pairs(clients) do
        table.insert(client_names, client.name)
      end
      lsp_value = "󱘖 " .. table.concat(client_names, ",")
    end

    local function update_formatter()
      local found, conform = pcall(require, "conform")
      if not found then
        formatter_value = ""
        return
      end

      local formatters = conform.list_formatters(0)
      if #formatters == 0 then
        formatter_value = ""
        return
      end

      local formatter_names = {}
      for _, f in ipairs(formatters) do
        table.insert(formatter_names, f.name)
      end
      formatter_value = "󰉢 " .. table.concat(formatter_names, ",")
    end

    local function update_dap_adapter()
      local found, dap = pcall(require, "dap")
      if not found then
        dap_value = ""
        return
      end

      local filetype = vim.bo.filetype
      if not filetype then
        dap_value = ""
        return
      end

      local configs = dap.configurations[filetype]
      if not configs or #configs == 0 then
        dap_value = ""
        return
      end

      local adapter_type = configs[1].type
      if not adapter_type then
        dap_value = ""
        return
      end

      dap_value = " " .. adapter_type
    end

    local function update_linter()
      local found, lint = pcall(require, "lint")
      if not found then
        linter_value = ""
        return
      end

      local filetype = vim.bo.filetype
      if not filetype or filetype == "" then
        linter_value = ""
        return
      end

      local linters = lint.linters_by_ft[filetype]
      if not linters or #linters == 0 then
        linter_value = ""
        return
      end

      linter_value = "󰁨 " .. table.concat(linters, ",")
    end

    -- Autocomandos para actualizar valores asíncronamente
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        update_lsp_clients()
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      callback = function()
        update_lsp_clients()
      end,
    })

    vim.api.nvim_create_autocmd("BufRead", {
      callback = function()
        update_lsp_clients()
        update_formatter()
        update_dap_adapter()
        update_linter()
      end,
    })

    require("lualine").setup {
      -- Barra superior
      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { {
          'filename',
          path = 1, -- 0: solo nombre, 1: ruta relativa, 2: ruta absoluta
        }, },
        lualine_x = {
          {
            function()
              return formatter_value
            end,
            color = { fg = "#a6e3a1" },
          },
          {
            function()
              return dap_value
            end,
            color = { fg = "#f38ba8" },
          },
          {
            function()
              return linter_value
            end,
            color = { fg = "#f9e2af" },
          },
        },
        lualine_y = {
          {
            function()
              return lsp_value
            end,
            color = { fg = "#89b4fa" },
          },
        },
        lualine_z = { "filetype" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
