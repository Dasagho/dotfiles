local M = {}

local languages = require('config.languages').languages
local ensure_installed = require('config.languages').ensure_installed_lsp

function M.setupLspServers()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.inlayHint = {
    dynamicRegistration = false,
    resolveSupport = {
      properties = { 'label', 'tooltip', 'textEdits', 'paddingLeft', 'paddingRight' },
    },
  }

  local flags = { debounce_text_changes = 150 }

  for _, lang in pairs(languages) do
    local settings = vim.tbl_deep_extend('force', lang.lsp_settings, { capabilities = capabilities, flags = flags, single_file_support = false })
    if lang.lsp_name ~= nil then
      vim.lsp.config(lang.lsp_name, settings)
      vim.lsp.enable(lang.lsp_name)
    end
  end
end

return M
