local M = {}

M.ensure_installed_lsp = {}
M.languages = {
  c_cpp = {
    required = true,
    lsp_name = 'clangd',
    mason_lsp_id = 'clangd',
    lsp_settings = {},
    dap_adapter = 'codelldb',
    linter = 'cpplint',
    formatter = 'clang-format',
    filetype = { 'c', 'cpp', 'h', 'hpp' },
  },

  python = {
    required = false,
    lsp_name = 'pyright',
    mason_lsp_id = 'pyright',
    lsp_settings = {},
    dap_adapter = 'debugpy',
    linter = 'flake8',
    formatter = 'black',
    filetype = { 'python' },
  },

  go = {
    required = true,
    lsp_name = 'gopls',
    mason_lsp_id = 'gopls',
    lsp_settings = {},
    dap_adapter = 'delve',
    formatter = { 'gofumpt', 'goimports', 'goimports-reviser', 'gomodifytags', 'golines' },
    filetype = { 'go', 'gomod', 'gowork', 'gotmpl' },
  },

  rust = {
    required = false,
    lsp_name = 'rust-analyzer',
    mason_lsp_id = 'rust-analyzer',
    lsp_settings = {},
    dap_adapter = 'codelldb',
    linter = 'clippy',
    formatter = 'rustfmt',
    filetype = { 'rust' },
  },

  javascript_typescript = {
    required = true,
    lsp_name = 'ts_ls',
    mason_lsp_id = 'typescript-language-server',
    lsp_settings = {},
    dap_adapter = 'js',
    linter = 'eslint',
    formatter = 'prettier',
    filetype = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },

  html = {
    required = false,
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'html' },
  },

  css = {
    required = false,
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'css', 'scss', 'less' },
  },

  json = {
    required = true,
    lsp_name = 'json-lsp',
    lsp_settings = {
      on_new_config = function(new_config)
        new_config.lsp_settings.json.schemas = new_config.lsp_settings.json.schemas or {}
        vim.list_extend(new_config.lsp_settings.json.schemas, require('schemastore').json.schemas())
      end,
      lsp_settings = {
        json = {
          format = { enable = true },
          validate = { enable = true },
        },
      },
    },
    formatter = 'prettier',
    filetype = { 'json', 'jsonc' },
  },

  markdown = {
    required = true,
    lsp_name = 'marksman',
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'markdown' },
  },

  docker = {
    required = true,
    lsp_name = 'dockerls',
    mason_lsp_id = 'docker-language-server',
    lsp_settings = {},
    linter = 'hadolint',
    filetype = { 'dockerfile' },
  },

  docker_compose = {
    required = true,
    lsp_name = 'docker-compose-language-service',
    mason_lsp_id = 'docker-compose-language-service',
    lsp_settings = {},
    filetype = { 'yaml.docker-compose' },
  },

  sql = {
    required = false,
    lsp_name = 'sqls',
    mason_lsp_id = 'sqls',
    lsp_settings = {},
    formatter = 'sql-formatter',
    filetype = { 'sql', 'mysql', 'plsql' },
  },

  yaml = {
    required = true,
    lsp_name = 'yamlls',
    mason_lsp_id = 'yaml-language-server',
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'yaml', 'yml' },
  },

  bash = {
    required = true,
    lsp_name = 'bashls',
    mason_lsp_id = 'bash-language-server',
    lsp_settings = {},
    linter = 'shellcheck',
    formatter = 'shfmt',
    filetype = { 'sh', 'bash', 'zsh', 'fish' },
  },

  fish = {
    required = true,
    lsp_name = 'fish_lsp',
    mason_lsp_id = 'fish-lsp',
    lsp_settings = {},
    filetype = { 'fish' },
  },

  emmet = {
    required = false,
    lsp_name = 'emmet-ls',
    lsp_settings = {},
    filetype = { 'html', 'css' },
  },

  php = {
    required = false,
    lsp_name = 'phpactor',
    lsp_settings = {},
    dap_adapter = 'php-debug-adapter',
    linter = 'phpcs',
    formatter = 'php-cs-fixer',
    filetype = { 'php' },
  },

  lua = {
    required = true,
    lsp_name = 'lua_ls',
    mason_lsp_id = 'lua-language-server',
    lsp_settings = {
      Lua = { completion = { callSnippet = 'Replace' } },
    },
    formatter = 'stylua',
    filetype = { 'lua' },
  },
}

local function insert_if_exists(target_table, value)
  if value then
    if type(value) == 'table' then
      for _, v in ipairs(value) do
        table.insert(target_table, v)
      end
    else
      table.insert(target_table, value)
    end
  end
end

function M.ensure_installed()
  local ensure_installed = {}

  for _, lang in pairs(M.languages) do
    if lang.required == true then
      insert_if_exists(M.ensure_installed_lsp, lang.lsp_name)
      insert_if_exists(ensure_installed, lang.mason_lsp_id)
      insert_if_exists(ensure_installed, lang.formatter)
      insert_if_exists(ensure_installed, lang.linter)
      insert_if_exists(ensure_installed, lang.dap_adapter)
    end
  end

  require('mason-tool-installer').setup {
    ensure_installed = ensure_installed,
  }
end

M.ensure_installed()

return M
