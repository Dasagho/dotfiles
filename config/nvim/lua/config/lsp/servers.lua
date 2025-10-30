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

  local flags = { debounce_text_changes = 250 }

  local function on_attach(client, bufnr)
    -- apply perf tuning to each client/buffer
    require('config.perf').apply_lsp_defaults(client, bufnr)

    -- You can still add per-buffer keymaps here if you prefer doing it manually
    -- but note: you already set up keymaps via LspAttach autocmd in your lazy spec,
    -- so we don't *need* to repeat them here.
  end

  for _, lang in pairs(languages) do
    if lang.lsp_name ~= nil then
      local settings =
        vim.tbl_deep_extend('force', lang.lsp_settings, { capabilities = capabilities, flags = flags, single_file_support = false, on_attach = on_attach })

      vim.lsp.config(lang.lsp_name, settings)

      vim.lsp.enable(lang.lsp_name)
    end
  end
end

return M
