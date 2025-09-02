local M = {}

function M.setup()
  local servers = require 'config.lsp.servers'
  servers.setupLspServers()
end

return M
