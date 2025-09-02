local plugins = {}

local categories = {
  'ai',
  'completion',
  'core',
  'debug',
  'editor',
  'formatting',
  'git',
  'linting',
  'lsp',
  'mason',
  'misc',
  'tools',
  'ui',
}

for _, category in ipairs(categories) do
  local category_plugins = require('plugins.' .. category)
  vim.list_extend(plugins, category_plugins)
end

return plugins
