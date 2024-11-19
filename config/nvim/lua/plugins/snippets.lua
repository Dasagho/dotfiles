return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    local ls = require "luasnip"
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node

    ls.add_snippets("typescriptreact", {
      s("rafcts", {
        t "export type ",
        f(function()
          return vim.fn.expand "%:t:r" .. "Props"
        end),
        t " = {",
        t { "", "  children?: React.ReactNode" },
        t { "", "}" },
        t { "", "" },
        t "export const ",
        f(function()
          return vim.fn.expand "%:t:r"
        end),
        t ": React.FC<",
        f(function()
          return vim.fn.expand "%:t:r" .. "Props"
        end),
        t "> = ({ children }) => {",
        t { "", "  return (" },
        t { "", "    <>" },
        i(1, "content"),
        t { "", "    </>" },
        t { "", "  )" },
        t { "", "}" },
      }, {
        description = "Creates a React FC Component with TypeScript",
      }),
    })
  end,
}
