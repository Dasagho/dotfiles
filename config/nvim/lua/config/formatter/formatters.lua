local M = {}

function M.build_formatters_by_ft(langs)
  local formatters_by_ft = {}
  for _, lang_config in pairs(langs) do
    if lang_config.required then
      local formatter = type(lang_config.formatter) == 'table' and lang_config.formatter or { lang_config.formatter }
      for _, filetype in ipairs(lang_config.filetype) do
        formatters_by_ft[filetype] = formatter
      end
    end
  end
  return formatters_by_ft
end

return M
