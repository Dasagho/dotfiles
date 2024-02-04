-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.db_ui_env_variable_url = "localhost"
-- vim.g.db_ui_env_variable_name = "postgres"

vim.g.db_ui_auto_execute_table_helpers = 1

vim.g.dbs = {
  scriptura = "postgres://postgres:postgres@localhost:5432/postgres",
}
