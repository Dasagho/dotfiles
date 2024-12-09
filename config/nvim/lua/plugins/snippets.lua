return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = { "friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    local ls = require "luasnip"
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- Helper function to get the current file name without extension
    local function get_file_name_without_ext()
      return vim.fn.expand "%:t:r"
    end

    -- Snippet for both TypeScript React and TypeScript filetypes
    local rafcts = s("rafcts", {
      t "export interface ",
      f(function()
        return get_file_name_without_ext() .. "Props"
      end),
      t { " {", "" },
      t { "    " },
      i(2),
      t { "", "}", "" },
      t { "", "" },
      t "export const ",
      f(function()
        return get_file_name_without_ext()
      end),
      t " = ({",
      i(3),
      t "}: ",
      f(function()
        return get_file_name_without_ext() .. "Props"
      end),
      t { ") => {", "  return (" },
      t { "", "    <>" },
      t { "", "      <h1>" },
      i(1, get_file_name_without_ext()),
      t { "</h1>", "    </>" },
      t { "", "  );", "};" },
      t { "", "" },
    })

    local rafhts = s("rafhts", {
      t "export interface ",
      f(function()
        return vim.fn.expand "%:t:r" .. "Props"
      end),
      t " {",
      i(1),
      t "}",
      t { "", "" },
      t { "", "" },
      t "export const ",
      f(function()
        return vim.fn.expand "%:t:r"
      end),
      t " = ({",
      i(2),
      t "}: ",
      f(function()
        return vim.fn.expand "%:t:r" .. "Props"
      end),
      t ") => {",
      t { "", "   " },
      i(3),
      t { "", "" },
      t { "", "   return " },
      i(4),
      t { "", "}" },
    })

    ls.add_snippets("typescriptreact", { rafcts, rafhts })
    ls.filetype_extend("typescript", { "typescriptreact" })
  end,
}
