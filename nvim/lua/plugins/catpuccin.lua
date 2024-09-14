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
            },
            integrations = {
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                treesitter = true,
                cmp = true,
            },
        })

    end
}
