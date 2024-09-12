return {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
        require('catppuccin').setup({
            flavour = "mocha", -- Opciones: latte, frappe, macchiato, mocha
            transparent_background = false, -- Si deseas un fondo transparente
            term_colors = true, -- Si deseas que los colores del terminal se integren
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
            },
            integrations = {
                -- Aquí puedes agregar integraciones con otros plugins
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                -- Añade otras integraciones si las usas
            },
        })

        -- Activar el esquema de color
        vim.cmd.colorscheme "catppuccin"
    end
}
