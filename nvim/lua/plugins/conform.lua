return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      --- https://github.com/sql-formatter-org/sql-formatter?tab=readme-ov-file#configuration-options
      sql_formatter = {
        language = "plsql", --- https://github.com/sql-formatter-org/sql-formatter/blob/master/docs/language.md
        tabWidth = 2,
        keywordCase = "upper",
        linesBetweenQueries = 2,
      },
    },
    formatters_by_ft = {
      markdown = { "markdownlint" },
      python = { "autopep8" },
      typescript = { "ts-standard" },
      sql = { "sql_formatter" },
      go = { "gopls" },
    },
  },
}
