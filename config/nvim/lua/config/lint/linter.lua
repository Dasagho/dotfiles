local M = {}

function M.build_linters_by_ft(langs)
  local linters_by_ft = {}
  for _, lang in pairs(langs) do
    if lang.required then
      for _, filetype in ipairs(lang.filetype) do
        linters_by_ft[filetype] = { lang.linter }
      end
    end
  end
  return linters_by_ft
end

return M
