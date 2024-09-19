return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            projects = {
                "~/currentProject/",
                "~/svn/DIALAPPLET/tags/*",
                "~/svn/DIALAPPLET/trunk/"
            }
        }
    end
}
