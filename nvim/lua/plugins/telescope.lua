return {
    'nvim-telescope/telescope.nvim', 
    dependencies = {
        'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- Necesario para compilar el plugin nativo
      },
    },

    config = function()
        vim.keymap.set('n', '<Leader><Space>', ':Telescope find_files<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>ff', ':Telescope grep_string<CR>', { noremap = true, silent = true })
        require('telescope').load_extension('fzf')
    end,

    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = { prompt_position = "top" },
        },
    },
}
