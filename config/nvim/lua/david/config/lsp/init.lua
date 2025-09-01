local M = {}

function M.setup()
  local servers = require 'david.config.lsp.servers'
  servers.setupLspServers()
end

return M
