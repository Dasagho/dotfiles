local M = {}

local languages = require('david.config.languages').languages
local ensure_installed = {}

for _, lang in pairs(languages) do
  if lang.required == true then
    table.insert(ensure_installed, lang.lsp_name)
  end
end

function M.ensure_installed()
  require('mason-lspconfig').setup {
    ensure_installed = ensure_installed,
    automatic_enable = false,
  }
end

function M.setupLspServers()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.inlayHint = {
    dynamicRegistration = false,
    resolveSupport = {
      properties = { 'label', 'tooltip', 'textEdits', 'paddingLeft', 'paddingRight' },
    },
  }

  for _, lang in pairs(languages) do
    local settings = vim.tbl_deep_extend('force', lang.lsp_settings, { capabilities = capabilities })
    vim.lsp.config(lang.lsp_name, settings)
    vim.lsp.enable(lang.lsp_name)
  end
end

return M
