return {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("l", "󰦛  Restore session", ":Autosession search <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("t", "  View TODOs", ":TodoTelescope <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("m", "  Open Mason", ":Mason <CR>"),
            { type = "padding", val = 1 },
            dashboard.button("c", "  Edit Neovim config", ":cd ~/.config/nvim | e ~/.config/nvim/init.lua<CR>"),
            { type = "padding", val = 1 },
            dashboard.button("q", "󰅙  Quit NVIM", ":qa<CR>"),
            { type = "padding", val = 1 },
        }

        -- Pie de página
        dashboard.section.footer.val = "🚀 Alpha.nvim tema Doom!"

        alpha.setup({
            layout = {
                { type = "padding", val = 6 },  -- Añadir espacio arriba para centrar el contenido verticalmente
                { type = "text", val = dashboard.section.header.val, opts = { position = "center" } },  -- Header centrado
                { type = "padding", val = 2 },  -- Espacio entre header y botones
                { type = "group", val = dashboard.section.buttons.val, opts = { position = "center" } },  -- Botones centrados
                { type = "padding", val = 2 },  -- Espacio entre botones y footer
                { type = "text", val = dashboard.section.footer.val, opts = { position = "center" } },  -- Footer centrado
            },
        })
    end,
}
