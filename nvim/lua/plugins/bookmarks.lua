return {
    'crusj/bookmarks.nvim',
    keys = {
        { "<tab><tab>", mode = { "n" } },
    },
    branch = 'main',
    dependencies = { 'nvim-web-devicons' },
    config = function()
        require("bookmarks").setup()
        require("telescope").load_extension("bookmarks")

        local map = vim.api.nvim_set_keymap
    end
}
