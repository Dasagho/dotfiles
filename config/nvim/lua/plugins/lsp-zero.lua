-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "VonHeikemen/lsp-zero.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    local lsp = require "lsp-zero"

    -- Lista de servidores que estás usando
    local servers = {
      "ts_ls",
      "clangd",
      "jdtls",
      "html",
      "cssls",
      "jsonls",
      "marksman",
      "lua_ls",
      "dockerls",
      "docker_compose_language_service",
      "pyright",
      "sqls",
      "yamlls",
      "phpactor",
      "bashls",
      "emmet_ls",
    } -- agrega los servidores que necesites

    -- Configura cada servidor con las capacidades modificadas
    for _, server in ipairs(servers) do
      lsp.configure(server, {
        -- Aquí puedes agregar otras configuraciones específicas del servidor si lo deseas
      })
    end

    -- Configuraciones específicas de servidores
    lsp.configure("ts_ls", {
      root_dir = require("lspconfig").util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
      single_file_support = false,
      settings = {
        typescript = {
          preferences = {
            importModuleSpecifier = "non-relative",
            includePackageJsonAutoImports = "on",
          },
        },
        javascript = {
          preferences = {
            importModuleSpecifier = "non-relative",
            includePackageJsonAutoImports = "on",
          },
        },
      },
      init_options = {
        preferences = {
          jsxAttributeCompletionStyle = "braces", -- Autocompletado JSX
        },
      },
    })

    lsp.configure("lua_ls", {
      on_attach = function(client)
        client.server_capabilities.document_formatting = true
      end,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT", -- Versión usada por Neovim
          },
          diagnostics = {
            globals = { "vim" }, -- Reconoce la variable global `vim`
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true), -- Archivos de Neovim
            checkThirdParty = false, -- Desactiva la advertencia de terceros
          },
          telemetry = {
            enable = false, -- Desactiva la telemetría
          },
        },
      },
    })

    lsp.configure("emmet_ls", {
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "jsx",
        "tsx",
      },
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
          },
        },
      },
    })

    vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(vim.lsp.handlers.codeAction, {
      signs = false,
    })

    -- Configurar los diagnósticos
    vim.diagnostic.config {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = false,
      severity_sort = false,
      float = false,
    }

    local signs = { Error = "E", Warn = "W", Hint = "A", Info = "I" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    lsp.setup {
      manage_nvim_cmp = true, -- Maneja la configuración de autocompletado
      set_lsp_keymaps = true, -- Activa los keymaps por defecto
    }
  end,
}
