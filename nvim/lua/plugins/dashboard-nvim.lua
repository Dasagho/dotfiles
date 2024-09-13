return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup({
            theme = 'hyper',  -- Especifica el tema Hyper aquí
            config = {
                header = {
                    -- Aquí puedes agregar el encabezado que deseas ver al iniciar
                    -- Puedes dejarlo vacío para el tema predeterminado de Hyper
                    '',
                    'Welcome to Neovim',
                    'Hyper Theme',
                    ''
                },
                shortcut = {
                    { desc = ' Files', group = '@property', action = 'Telescope find_files', key = 'f' },
                    { desc = ' Grep', group = 'Label', action = 'Telescope live_grep', key = 'g' },
                    { desc = ' File Explorer', group = 'Label', action = 'NvimTreeToggle', key = 'e' },
                    { desc = ' Bookmarks', group = 'Number', action = 'Telescope marks', key = 'm' },
                    { desc = ' Plugins', group = 'Number', action = 'Lazy', key = 'p' }
                },
                footer = { 'Start coding!' }, -- Footer personalizado
            }
        })
    end
}
