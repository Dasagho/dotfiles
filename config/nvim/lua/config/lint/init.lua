local M = {}

local build_linters = require('config.lint.linter').build_linters_by_ft
local languages = require('config.languages').languages

M.linters = build_linters(languages)

return M
