return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = { "friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
    require("luasnip.loaders.from_vscode").lazy_load { paths = "../../snippets" }
    require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
  end,
}
