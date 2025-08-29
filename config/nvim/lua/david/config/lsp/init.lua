local M = {}

function M.setup()
  local servers = require 'david.config.lsp.servers'
  servers.ensure_installed()
  servers.setupLspServers()
end

return M
