local M = {}

local build_formatters = require('config.formatter.formatters').build_formatters_by_ft
local languages = require('config.languages').languages

M.formatters = build_formatters(languages)

return M
