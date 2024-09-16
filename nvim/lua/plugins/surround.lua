return {
    "kylechui/nvim-surround",
    version = "*", -- Utiliza la última versión estable
    event = "VeryLazy", -- Carga de manera perezosa cuando sea necesario
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                insert = "<C-g>s",  -- (opcional) Surround en modo insert con <C-g>s
                normal = "<leader>ys", -- Añadir surround
                delete = "<leader>ds", -- Eliminar surround
                change = "<leader>cs", -- Cambiar surround
                visual = "<leader>S",  -- Añadir surround en modo visual
            },
        })
    end,
}