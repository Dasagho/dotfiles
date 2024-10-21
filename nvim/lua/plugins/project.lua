return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            patterns = { ".git", "_darcs", ".hg", ".bzr", "Makefile", "package.json", ".idea", ".vscode" },
            silent_chdir = false,
        }
    end
}
