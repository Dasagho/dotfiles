return {
    'crusj/bookmarks.nvim',
    branch = 'main',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-web-devicons' },
    config = function()
        require("bookmarks").setup({
            keymap = {
                toggle = "<leader>mz",  -- Agrega o elimina un bookmark en la línea actual
                add = "<leader>mm",     -- Añadir bookmark local
                add_global = "<leader>mg", -- Añadir bookmark global
                delete_on_virt = "<leader>md", -- Eliminar todos los bookmarks en el archivo actual
                jump = "<CR>",   -- Saltar al bookmark seleccionado en Telescope
                order = "<leader>mo", -- Ordenar bookmarks por frecuencia o tiempo
            }
        })
        require("telescope").load_extension("bookmarks")
    end
}
