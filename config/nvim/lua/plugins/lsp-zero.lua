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
    local home = os.getenv("HOME")

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
      -- "intelephense",
      "phpactor",
      "bashls",
      "emmet_ls",
      "gopls",
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
            checkThirdParty = false,                           -- Desactiva la advertencia de terceros
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

    local java_home = home .. "/.sdkman/candidates/java/current"

    lsp.configure("jdtls", {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx2G", -- Ajusta la memoria según tu sistema
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        -- Usamos vim.fn.glob para resolver el wildcard del launcher
        "-jar", vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
        1),
        "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        -- El workspace se crea en función del directorio actual
        "-data", home .. "/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
      },

      -- Se detecta el proyecto mediante la presencia de gradlew, mvnw o .git
      root_dir = require("lspconfig.util").root_pattern("gradlew", "mvnw", ".git"),

      settings = {
        java = {
          -- Habilitamos CodeLens para referencias e implementaciones (muy útiles en proyectos Spring Boot y Maven)
          referencesCodeLens = { enabled = true },
          implementationsCodeLens = { enabled = true },
          -- Formateo y ayuda de firma
          format = { enabled = true },
          signatureHelp = { enabled = true },
          -- Usamos fernflower como decompilador (útil para ver código fuente de dependencias)
          contentProvider = { preferred = "fernflower" },

          -- Configuración específica para proyectos Maven:
          maven = {
            downloadSources = true, -- Descarga las fuentes de las dependencias para mejorar el autocompletado
            updateSnapshots = true, -- Actualiza las versiones snapshot
          },

          -- (Opcional) Si deseas marcar que trabajas con Spring Boot, puedes incluir una sección spring;
          -- actualmente jdtls reconoce los proyectos Spring Boot siempre que tengan los starters necesarios.
          spring = {
            boot = {
              enabled = true,
              -- Aquí podrías agregar más opciones si en el futuro jdtls o sus plugins lo requieren
            },
          },

          -- Configuración de los runtimes: se usa la versión de Java instalada vía SDKMAN
          configuration = {
            runtimes = {
              {
                name = "Default",
                path = java_home, -- Asegúrate de que 'java_home' esté correctamente definido (por ejemplo, con SDKMAN)
              },
            },
          },
        },
      },

      on_attach = function(client, bufnr)
        -- Configuración para DAP en Java, permitiendo el hot code replace
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        -- Se añaden los comandos de jdtls (por ejemplo, para organizar imports o ejecutar acciones específicas)
        require("jdtls").setup.add_commands()
        -- Se refresca CodeLens en eventos comunes
        if client.server_capabilities.codeLensProvider then
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = function()
              vim.lsp.codelens.refresh()
            end,
          })
        end
      end,
    })

    -- Configurar los diagnósticos
    vim.diagnostic.config {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
    }

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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
