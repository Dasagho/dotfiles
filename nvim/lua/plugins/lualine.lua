return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress", opt = true },
  event = "VeryLazy", -- puede cargarse después del inicio
  config = function()
    local function get_attached_lsp()
      local clients = vim.lsp.get_active_clients { bufnr = 0 }
      if #clients == 0 then
        return ""
      end

      local client_names = {}
      for _, client in pairs(clients) do
        table.insert(client_names, client.name)
      end
      return " " .. table.concat(client_names, ",")
    end

    local function get_conform_formatter()
      local found, conform = pcall(require, "conform")
      if not found then
        return ""
      end

      local formatters = conform.list_formatters(0)
      if #formatters == 0 then
        return ""
      end

      local formatter_names = {}
      for _, formatter in ipairs(formatters) do
        table.insert(formatter_names, formatter.name)
      end
      return "󰉢 " .. table.concat(formatter_names, ",")
    end

    local function get_dap_adapter()
      local found, dap = pcall(require, "dap")
      if not found then
        return ""
      end

      local filetype = vim.bo.filetype
      if not filetype or not dap.configurations[filetype] then
        return ""
      end

      return " " .. filetype
    end

    -- Cache para mejorar rendimiento
    local cache_time = 1000 -- 1 segundo
    local cache = {
      lsp = { value = "", last_update = 0 },
      formatter = { value = "", last_update = 0 },
      dap = { value = "", last_update = 0 },
    }

    local function get_cached_value(key, getter)
      local current_time = vim.loop.now()
      if (current_time - cache[key].last_update) > cache_time then
        cache[key].value = getter()
        cache[key].last_update = current_time
      end
      return cache[key].value
    end

    require("lualine").setup {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
        },
        lualine_x = {
          {
            function()
              return get_cached_value("lsp", get_attached_lsp)
            end,
            color = { fg = "#89b4fa" },
          },
          {
            function()
              return get_cached_value("formatter", get_conform_formatter)
            end,
            color = { fg = "#a6e3a1" },
          },
          {
            function()
              return get_cached_value("dap", get_dap_adapter)
            end,
            color = { fg = "#f38ba8" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
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
