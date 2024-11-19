return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup {
      patterns = { ".git", "_darcs", ".hg", ".bzr", "Makefile", "package.json", ".idea", ".vscode" },
      silent_chdir = false,
    }
  end,
}
