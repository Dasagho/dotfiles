local M = {}

M.languages = {
  c_cpp = {
    required = true,
    lsp_name = 'clangd',
    lsp_settings = {},
    dap_adapter = 'codelldb',
    linter = 'cpplint',
    formatter = 'clang-format',
    ft = { 'c', 'cpp', 'h', 'hpp' },
  },

  python = {
    required = false,
    lsp_name = 'pyright',
    lsp_settings = {},
    dap_adapter = 'debugpy',
    linter = 'flake8',
    formatter = 'black',
    filetype = { 'python' },
  },

  go = {
    required = false,
    lsp_name = 'gopls',
    lsp_settings = {},
    dap_adapter = 'delve',
    formatter = { 'gofumpt', 'goimports', 'goimports-reviser', 'gomodifytags', 'golines' },
    filetype = { 'go', 'gomod', 'gowork', 'gotmpl' },
  },

  rust = {
    required = false,
    lsp_name = 'rust-analyzer',
    lsp_settings = {},
    dap_adapter = 'codelldb',
    linter = 'clippy',
    formatter = 'rustfmt',
    filetype = { 'rust' },
  },

  javascript_typescript = {
    required = true,
    lsp_name = 'ts_ls',
    lsp_settings = {},
    dap_adapter = 'js',
    linter = 'eslint_d',
    formatter = 'prettier',
    filetype = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },

  html = {
    required = false,
    lsp_name = 'html',
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'html' },
  },

  css = {
    required = false,
    lsp_name = 'cssls',
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'css', 'scss', 'less' },
  },

  json = {
    required = true,
    lsp_name = 'jsonls',
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
    lsp_settings = {},
    linter = 'hadolint',
    filetype = { 'dockerfile' },
  },

  docker_compose = {
    required = true,
    lsp_name = 'docker_compose_language_service',
    lsp_settings = {},
    filetype = { 'yaml.docker-compose' },
  },

  sql = {
    required = false,
    lsp_name = 'sqls',
    lsp_settings = {},
    formatter = 'sql-formatter',
    filetype = { 'sql', 'mysql', 'plsql' },
  },

  yaml = {
    required = true,
    lsp_name = 'yamlls',
    lsp_settings = {},
    formatter = 'prettier',
    filetype = { 'yaml', 'yml' },
  },

  bash = {
    required = true,
    lsp_name = 'bashls',
    lsp_settings = {},
    linter = 'shellcheck',
    formatter = 'shfmt',
    filetype = { 'sh', 'bash', 'zsh', 'fish' },
  },

  fish = {
    required = true,
    lsp_name = 'fish_lsp',
    lsp_settings = {},
    filetype = { 'fish' },
  },

  emmet = {
    required = false,
    lsp_name = 'emmet_ls',
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
    lsp_settings = {
      Lua = { completion = { callSnippet = 'Replace' } },
    },
    formatter = 'stylua',
    filetype = { 'lua' },
  },
}

return M
