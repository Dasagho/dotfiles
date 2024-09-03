require('telescope').setup{
    defaults = {
        -- Configuraciones de Telescope
        mappings = {
            i = {
                ["<C-n>"] = require('telescope.actions').move_selection_next,
                ["<C-p>"] = require('telescope.actions').move_selection_previous,
            },
        },
    }
}
