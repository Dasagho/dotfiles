local M = {}

function M.setup()
  local servers = require 'config.lsp.servers'
  servers.setupLspServers()
  require('config.languages').ensure_installed()
end

return M
